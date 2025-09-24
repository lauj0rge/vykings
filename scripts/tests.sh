#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:-dev}"
TFVARS_FILE="terraform/env/${ENVIRONMENT}.tfvars"
declare -A TFVARS=()

# ---------- Parse tfvars ----------
parse_tfvars() {
  local file="$1"
  [[ -f "$file" ]] || return
  local regex='^[[:space:]]*([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*=[[:space:]]*"([^"]*)"[[:space:]]*$'
  while IFS= read -r line; do
    line="${line%%#*}"
    [[ $line =~ ^[[:space:]]*$ ]] && continue
    if [[ $line =~ $regex ]]; then
      TFVARS["${BASH_REMATCH[1]}"]="${BASH_REMATCH[2]}"
    fi
  done < "$file"
}
get_tfvar_value() { echo "${TFVARS[$1]:-${2:-}}"; }
parse_tfvars "$TFVARS_FILE"

# ---------- Vars ----------
CLUSTER_NAME="vyking-${ENVIRONMENT}"
KUBECONFIG_PATH="$(get_tfvar_value kubeconfig_path "~/.kube/vyking-${ENVIRONMENT}-config")"
ARGO_NS="$(get_tfvar_value argocd_namespace "argocd-${ENVIRONMENT}")"
FRONTEND_NS="$(get_tfvar_value frontend_namespace "frontend-${ENVIRONMENT}")"
BACKEND_NS="$(get_tfvar_value backend_namespace "backend-${ENVIRONMENT}")"
MYSQL_NS="$(get_tfvar_value mysql_namespace "mysql-${ENVIRONMENT}")"
FRONTEND_HOST="$(get_tfvar_value frontend_host "frontend-${ENVIRONMENT}.local")"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S %Z')"

# ---------- Printer helpers ----------
run_cmd() {
  local title="$1"; shift
  echo "### ${title}"
  echo '```bash'
  echo "+ $*"
  if ! "$@"; then echo "[command failed $?]"; fi
  echo '```'
  echo
}

namespace_overview() {
  local ns="$1"
  if ! kubectl get ns "$ns" >/dev/null 2>&1; then
    echo "❌ Namespace \`${ns}\` not found." && return 1
  fi
  local resources=(pods deploy statefulset  svc ingress)
  for kind in "${resources[@]}"; do
    run_cmd "${kind^}" kubectl get "$kind" -n "$ns" -o wide
  done
  run_cmd "Resource Usage (pods)" kubectl top pods -n "$ns"
}

# ---------- Report ----------
echo "# 🧪 Cluster Test Results for \`${ENVIRONMENT}\`"
echo
echo "## 📋 Summary"
cat <<EOF
- **Generated:** ${TIMESTAMP}
- **Environment:** \`${ENVIRONMENT}\`
- **Cluster Name:** \`${CLUSTER_NAME}\`
- **Kubeconfig Path:** \`${KUBECONFIG_PATH}\`
- **tfvars source:** \`${TFVARS_FILE:-defaults}\`
EOF
echo

echo "## 🧭 Access Checks"
run_cmd "kubectl version" kubectl version
run_cmd "Current context" kubectl config current-context
run_cmd "Available contexts" kubectl config get-contexts

echo "## 🌐 Cluster Overview"
for kind in cluster-info nodes ns pv storageclass; do
  run_cmd "$kind" kubectl get $kind ${kind/cluster-info/}
done
for kind in pods svc ingress deploy statefulset cronjobs hpa; do
  run_cmd "$kind (all namespaces)" kubectl get "$kind" -A -o wide
done
run_cmd "Resource usage (nodes)" kubectl top nodes
run_cmd "Resource usage (pods, all namespaces)" kubectl top pods -A

echo "## 🚦 Argo CD "
namespace_overview "$ARGO_NS" || true

[[ -n "$FRONTEND_NS" ]] && echo "## 🎨 Frontend (\`${FRONTEND_NS}\`)" && namespace_overview "$FRONTEND_NS" || true
[[ -n "$BACKEND_NS"  ]] && echo "## ⚙️ Backend (\`${BACKEND_NS}\`)"   && namespace_overview "$BACKEND_NS"  || true
[[ -n "$MYSQL_NS"    ]] && echo "## 🛢️ MySQL (\`${MYSQL_NS}\`)"     && namespace_overview "$MYSQL_NS"    || true

echo "✅ Tests complete."
