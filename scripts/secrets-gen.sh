#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:-dev}"
if [[ "$ENVIRONMENT" != "dev" && "$ENVIRONMENT" != "prod" ]]; then
  echo "❌ Unsupported environment: ${ENVIRONMENT}. Use dev or prod."
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SECRETS_FILE="${SCRIPT_DIR}/secrets.env"
SEALED_DIR="${REPO_ROOT}/infrastructure/sealed"

if [[ ! -f "$SECRETS_FILE" ]]; then
  echo "❌ ${SECRETS_FILE} not found. Please create it first."
  exit 1
fi

source "$SECRETS_FILE"

case "$ENVIRONMENT" in
  dev)
    DB_ROOT_PASS="${DEV_DB_ROOT_PASS:-}"
    DB_USER="${DEV_DB_USER:-}"
    DB_PASS="${DEV_DB_PASS:-}"
    DB_NAME="${DEV_DB_NAME:-}"
    ;;
  prod)
    DB_ROOT_PASS="${PROD_DB_ROOT_PASS:-}"
    DB_USER="${PROD_DB_USER:-}"
    DB_PASS="${PROD_DB_PASS:-}"
    DB_NAME="${PROD_DB_NAME:-}"
   ;;
esac
REQUIRED_VARS=(DB_ROOT_PASS DB_USER DB_PASS DB_NAME)
for var in "${REQUIRED_VARS[@]}"; do
  if [[ -z "${!var:-}" ]]; then
    echo "❌ Missing ${var} for ${ENVIRONMENT} in ${SECRETS_FILE}"
    exit 1
  fi
done

MYSQL_SECRET_NAME="mysql-${ENVIRONMENT}-secret"
MYSQL_CRED_NAME="mysql-credentials-${ENVIRONMENT}"
MYSQL_HOST="mysql.mysql-${ENVIRONMENT}.svc.cluster.local"
MYSQL_PORT="3306"

mkdir -p "$SEALED_DIR"

echo "==> Generating sealed secrets for ${ENVIRONMENT}"

kubectl create secret generic "$MYSQL_CRED_NAME" \
  -n "backend-${ENVIRONMENT}" \
  --from-literal=username="$DB_USER" \
  --from-literal=password="$DB_PASS" \
  --from-literal=database="$DB_NAME" \
  --from-literal=host="$MYSQL_HOST" \
  --from-literal=port="$MYSQL_PORT" \
  --dry-run=client -o yaml | kubeseal -o yaml > "${SEALED_DIR}/${MYSQL_CRED_NAME}.yaml"

kubectl create secret generic "$MYSQL_SECRET_NAME" \
  -n "mysql-${ENVIRONMENT}" \
  --from-literal=mysql-root-password="$DB_ROOT_PASS" \
  --from-literal=mysql-username="$DB_USER" \
  --from-literal=mysql-password="$DB_PASS" \
  --from-literal=mysql-database="$DB_NAME" \
  --dry-run=client -o yaml | kubeseal -o yaml > "${SEALED_DIR}/${MYSQL_SECRET_NAME}.yaml"

echo "✅ SealedSecrets generated for ${ENVIRONMENT}"

# -------------------------
# 3.1. Secure Git commit & push of sealed secrets
# -------------------------
echo "==> Securely committing sealed secrets to Git"

cd "$REPO_ROOT"

if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "⚠️  Not in a git repository. Skipping git operations."
    cd - > /dev/null
    exit 0
fi
if [ -z "$(git config user.name)" ]; then
    git config --local user.name "DevOps Bot"
fi
if [ -z "$(git config user.email)" ]; then
    git config --local user.email "devops-bot@vyking.io"
fi

SEALED_FILES=(
    "infrastructure/sealed/${MYSQL_CRED_NAME}.yaml"
    "infrastructure/sealed/${MYSQL_SECRET_NAME}.yaml"
)

FILES_TO_ADD=()
for file in "${SEALED_FILES[@]}"; do
    if [[ -f "$file" ]]; then
        FILES_TO_ADD+=("$file")
    fi
done

if [ ${#FILES_TO_ADD[@]} -eq 0 ]; then
    echo "✅ No sealed secret files to commit"
else
    git add "${FILES_TO_ADD[@]}"
    if git diff --staged --quiet; then
        echo "✅ No changes in sealed secrets to commit"
    else
        COMMIT_MSG="chore: update sealed secrets for ${ENVIRONMENT} environment [auto-generated $(date +%Y%m%d-%H%M%S)]"

        if git commit -m "$COMMIT_MSG" --no-verify; then
            echo "✅ Sealed secrets committed locally"
            if git push --dry-run origin HEAD &> /dev/null; then
                if git push origin HEAD; then
                    echo "✅ Sealed secrets pushed to remote repository"
      else
                    echo "⚠️  Failed to push to remote. Error code: $?"
                    echo "The sealed secrets have been committed locally but not pushed to remote."
                    echo "Please push manually with: git push origin HEAD"
                fi
            else
                echo "⚠️  No push access or remote not configured. Committed locally only."
                echo "To configure remote: git remote add origin <your-repo-url>"
                echo "To push manually: git push -u origin HEAD"
            fi
        else
            echo "❌ Failed to commit sealed secrets. Error code: $?"
            echo "Continuing without git commit..."
        fi
    fi
fi

cd - > /dev/null