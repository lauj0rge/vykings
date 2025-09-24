#!/bin/bash
set -e

# Default environment = dev
ENVIRONMENT="${1:-dev}"
CLUSTER_NAME="vyking-${ENVIRONMENT}"
PF_FILE="/tmp/argocd-port-forward-${ENVIRONMENT}.pid"

echo "=== 🧹 Cleaning environment: $ENVIRONMENT ==="

# Safety confirmation
read -p "⚠️  Are you sure you want to destroy environment '$ENVIRONMENT'? (y/N): " CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
  echo "❌ Cleanup aborted."
  exit 1
fi

# 1. Terraform destroy
echo "==> Running Terraform destroy for environment: $ENVIRONMENT"
pushd "$(dirname "$0")/../terraform" > /dev/null

if [ -f "env/${ENVIRONMENT}.tfvars" ]; then
  terraform destroy -auto-approve -var-file="env/${ENVIRONMENT}.tfvars"
else
  terraform destroy -auto-approve
fi

popd > /dev/null

# 2. Kill port-forward if running
if [[ -f "$PF_FILE" ]]; then
  PF_PID=$(cat "$PF_FILE")
  if ps -p $PF_PID > /dev/null 2>&1; then
    echo "==> Stopping Argo CD port-forward (PID: $PF_PID)"
    kill $PF_PID || true
  fi
  rm -f "$PF_FILE"
fi

# 3. Delete k3d cluster
echo "==> Deleting k3d cluster: $CLUSTER_NAME"
k3d cluster delete "$CLUSTER_NAME" || true

# 4. Clean kubeconfig
echo "==> Cleaning kubeconfig for $CLUSTER_NAME"
rm -f "$HOME/.kube/${CLUSTER_NAME}-config"

# 5. List remaining clusters
echo "==> Remaining clusters:"
k3d cluster list

echo "=== ✅ Cleanup complete for $ENVIRONMENT ==="
