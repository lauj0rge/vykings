#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT=${1:-dev}
ARGO_NS=${2:-argocd-dev}

echo "==> Argo CD username: admin"
echo -n "==> Argo CD admin password: "
kubectl -n "$ARGO_NS" get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d && echo

# port-forward to local 8080
kubectl port-forward svc/argocd-server -n "$ARGO_NS" 8080:443 >/dev/null 2>&1 &
echo $! > "/tmp/argocd-port-forward-${ENVIRONMENT}.pid"

