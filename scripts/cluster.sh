#!/bin/bash

ENVIRONMENT="${1:-dev}"
CLUSTER_NAME="vyking-${ENVIRONMENT}"
ARGO_NS="argocd-${ENVIRONMENT}"

if [[ "$ENVIRONMENT" == "prod" ]]; then
  PORTS=(-p "8080:80@loadbalancer" -p "8443:443@loadbalancer")
else
  PORTS=()
fi

echo "==> Deleting existing cluster '$CLUSTER_NAME' (if any)..."
k3d cluster delete "$CLUSTER_NAME" || true

echo "==> Creating new cluster: $CLUSTER_NAME"
k3d cluster create "$CLUSTER_NAME" \
  --servers 1 \
  --agents 2 \
  "${PORTS[@]}" \
  --k3s-arg "--disable=traefik@server:0"
echo "==> Exporting kubeconfig to ~/.kube/${CLUSTER_NAME}-config"
mkdir -p ~/.kube
k3d kubeconfig get "$CLUSTER_NAME" > ~/.kube/${CLUSTER_NAME}-config
chmod 600 ~/.kube/${CLUSTER_NAME}-config
export KUBECONFIG=$HOME/.kube/${CLUSTER_NAME}-config

echo "==> Cluster info:"
kubectl cluster-info
kubectl get nodes -o wide

# -------------------------
# Preload Images
# -------------------------
IMAGES=(
  "rancher/mirrored-coredns-coredns:1.12.0"
  "rancher/local-path-provisioner:v0.0.30"
  "rancher/mirrored-metrics-server:v0.7.2"
  "registry.k8s.io/ingress-nginx/controller:v1.11.1"
  "registry.k8s.io/ingress-nginx/kube-webhook-certgen:v1.4.1"
  "nginx:1.25-alpine"
  "redis:7.2.8-alpine"
  "bitnami/mysql:8.0.39-debian-12-r1"
  "quay.io/argoproj/argocd:v3.1.5"
  "ghcr.io/dexidp/dex:v2.44.0"
  "python:3.11-slim-bullseye"
)

echo "==> Pulling and importing base images into $CLUSTER_NAME"
for IMAGE in "${IMAGES[@]}"; do
  echo "   -> $IMAGE"
  docker pull "$IMAGE"
  k3d image import "$IMAGE" -c "$CLUSTER_NAME" --keep-tools
done

docker build -t vyking-backend:${ENVIRONMENT} ./applications/backend/app
docker build -t vyking-frontend:${ENVIRONMENT} ./applications/frontend/app
k3d image import vyking-backend:${ENVIRONMENT} vyking-frontend:${ENVIRONMENT} -c "$CLUSTER_NAME" --keep-tools

# -------------------------
# Install SealedSecrets
# -------------------------
SEALED_TAG="0.27.1"
SEALED_IMAGE="bitnami/sealed-secrets-controller:${SEALED_TAG}"

echo "==> Pre-pulling SealedSecrets image: ${SEALED_IMAGE}"
docker pull "${SEALED_IMAGE}"

echo "==> Importing SealedSecrets image into k3d cluster: ${CLUSTER_NAME}"
k3d image import -c "${CLUSTER_NAME}" "${SEALED_IMAGE}" --keep-tools

echo "==> Installing SealedSecrets controller ${SEALED_TAG}"
kubectl apply -f "https://github.com/bitnami-labs/sealed-secrets/releases/download/v${SEALED_TAG}/controller.yaml"

echo "==> Waiting for SealedSecrets controller to be ready..."
kubectl rollout status deployment sealed-secrets-controller \
  -n kube-system --timeout=120s

echo "==> Cluster ${CLUSTER_NAME} is ready with SealedSecrets installed."

echo "==> Syncing kube-root-ca.crt into all namespaces..."
for ns in $(kubectl get ns --no-headers -o custom-columns=":metadata.name"); do
  echo "   -> Updating in $ns"
  kubectl get cm kube-root-ca.crt -n kube-system -o yaml | \
    sed "s/namespace: kube-system/namespace: $ns/" | \
    kubectl apply -f -
done
