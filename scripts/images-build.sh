#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT=${1:-dev}
CLUSTER_NAME="vyking-$ENVIRONMENT"

NGINX_BASE="nginx:latest"
PYTHON_BASE="python:latest"

FE_IMAGE="vyking-frontend:${ENVIRONMENT}"
BE_IMAGE="vyking-backend:${ENVIRONMENT}"

echo "==> Pulling base images"
docker pull "$NGINX_BASE"
docker pull "$PYTHON_BASE"

echo "==> Building images"
docker build  \
  --build-arg BASE_IMAGE="$NGINX_BASE" \
  --build-arg ENVIRONMENT="$ENVIRONMENT" \
  -t "$FE_IMAGE" ./applications/frontend/app

docker build  \
  --build-arg BASE_IMAGE="$PYTHON_BASE" \
  --build-arg ENVIRONMENT="$ENVIRONMENT" \
  -t "$BE_IMAGE" ./applications/backend/app

echo "==> Importing into k3d cluster: $CLUSTER_NAME"
k3d image import -c "$CLUSTER_NAME" "$FE_IMAGE" "$BE_IMAGE" --keep-tools
