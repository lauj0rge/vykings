# 🛠️ Troubleshooting Guide for Vyking DevOps Task

This guide consolidates the most common issues that appear in the Kubernetes + Argo CD + Helm + MySQL + Frontend/Backend stack used in this repository. Follow the quick workflow first, then jump to the component-specific sections for deeper debugging tips.

## 📋 Quick Troubleshooting Workflow

### 1. Confirm Cluster & Context
```bash
kubectl config current-context
kubectl get nodes -o wide
```
> If the commands fail, ensure your kubeconfig is loaded and the k3d cluster is running.

### 2. Inspect Argo CD Application Status
```bash
kubectl get applications -n argocd-dev
kubectl describe application frontend -n argocd-dev
```
| Status        | Meaning & Follow-up                                                                 |
|---------------|---------------------------------------------------------------------------------------|
| `Synced`      | Desired state matches the live cluster. Troubleshoot inside the workload namespace. |
| `OutOfSync`   | Run `argocd app sync <app> -n argocd-dev` and check the diff before applying.         |
| `Unknown`     | Argo CD cannot reach the target cluster. Validate the cluster secret and RBAC.       |

### 3. Check Pod Health
```bash
kubectl get pods -A -o wide
kubectl describe pod <pod-name> -n <namespace>
kubectl logs <pod-name> -n <namespace> --tail=100
```
Look for `ImagePullBackOff`, `CrashLoopBackOff`, or readiness probe failures and use the relevant section below.

### 4. Review Recent Events
```bash
kubectl get events -A --sort-by=.lastTimestamp | tail -20
```
Events highlight scheduling issues, failed mounts, or webhook rejections.

---

## 🎨 Frontend Issues (React + NGINX)

### Pod Keeps Restarting
- **Symptoms:** `CrashLoopBackOff` or repeated restarts in `kubectl get pods`.
- **Common root causes:**
    - Invalid NGINX configuration from Helm templating.
    - Missing environment variables required at container start.
    - Image reference pointing to a non-existing tag.
- **How to fix:**
  ```bash
  kubectl logs deployment/vyking-app-frontend -n frontend-dev
  kubectl get deploy vyking-app-frontend -n frontend-dev -o yaml | grep image:
  ```
    - Validate `applications/vyking-app/templates/frontend/configmap.yaml` for syntax errors.
    - Confirm the chart values reference a published image tag.
    - Re-deploy with `argocd app sync vyking-app -n argocd-dev` after fixes.

### Ingress Not Accessible
- **Symptoms:** `curl`/browser timeout, ingress stuck in `Pending`.
- **Troubleshooting steps:**
  ```bash
  kubectl get ingress -n frontend-dev
  kubectl describe ingress vyking-app-frontend -n frontend-dev
  kubectl get svc -n ingress-nginx
  ```
    - If `EXTERNAL-IP` is `<pending>` in a local cluster, port-forward the controller:
      ```bash
      kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 8443:443
      ```
      Access via `https://frontend-dev.local:8443`.
    - Verify DNS/hosts file points to the ingress controller IP when running outside of k3d.

### Wrong Backend URL or CORS Failures
- **Symptoms:** Frontend works, but API calls fail with 40x/50x or CORS errors in the browser console.
- **Checklist:**
    - Inspect `frontend/src/app.js` (or equivalent) and ensure API calls use `/api` with relative paths.
    - Confirm ingress annotations include the rewrite/forwarding rules required for `/api`.
    - Check ConfigMap/Environment variables injected into the deployment:
      ```bash
      kubectl describe configmap vyking-app-frontend-nginx-config -n frontend-dev
      kubectl exec deploy/vyking-app-frontend -n frontend-dev -- env | grep -i api
      ```
    - Update the backend ingress to allow correct CORS headers (`Access-Control-Allow-Origin`, etc.).

### Static Assets Returning 404
- Ensure `nginx.conf` serves the `/static` directory.
- Check that the container image builds assets before packaging (run CI/CD build locally if needed).
- Re-sync Argo CD after committing fixes to the Helm chart or Dockerfile.

---

## ⚙️ Backend Issues (Node/Express or similar)

### Argo CD Shows `OutOfSync`
- Usually indicates Helm value drift or missing Kubernetes objects.
- Investigate with:
  ```bash
  argocd app diff vyking-app -n argocd-dev
  kubectl get events -n backend-dev --sort-by=.lastTimestamp | tail -20
  ```
- Update `values.yaml` or secrets to reflect the desired state, then `argocd app sync vyking-app -n argocd-dev`.

### Pod Cannot Reach MySQL
- **Symptoms:** Application logs contain `ECONNREFUSED` or connection timeout to `mysql:3306`.
- **Steps:**
  ```bash
  kubectl logs deployment/vyking-app-backend -n backend-dev
  kubectl get svc mysql -n mysql-dev
  ```
    - Ensure database host resolves to `mysql.mysql-dev.svc.cluster.local` and credentials match the Secret.
    - Confirm network policies (if any) allow traffic from backend to MySQL.
    - Run an exec test:
      ```bash
      kubectl exec deploy/vyking-app-backend -n backend-dev -- nc -zv mysql.mysql-dev.svc.cluster.local 3306
      ```

### Image Pull or Start Failures
- Check for `ImagePullBackOff` via `kubectl describe pod`.
- Verify image registry credentials (Secret referenced in the ServiceAccount).
- Confirm the deployment references an existing tag and repository.
- For Node apps, ensure start scripts are executable and dependencies are installed during image build.

### API Returns 500 Errors
- Inspect application logs and recent releases:
  ```bash
  kubectl logs deployment/vyking-app-backend -n backend-dev --tail=200
  ```
- Validate ConfigMaps and Secrets (e.g., JWT keys, third-party API tokens).
- Confirm database migrations have run (check the migration job or init container status).

---

## 🛢️ MySQL Issues

### StatefulSet in `CrashLoopBackOff`
- Fetch logs and describe the StatefulSet:
  ```bash
  kubectl logs statefulset/mysql -n mysql-dev
  kubectl describe pod mysql-0 -n mysql-dev
  ```
- Common issues & fixes:
    - **Wrong root password:** Recreate the sealed secret and re-sync.
    - **Volume mount errors:** Ensure the StorageClass exists and the PVC is bound.
    - **Insufficient resources:** Increase CPU/memory requests in `values.yaml`.

### PVC or Volume Stuck Pending
```bash
kubectl get pvc -n mysql-dev
kubectl describe pvc data-mysql-0 -n mysql-dev
```
- Ensure the cluster has a default StorageClass or specify one explicitly in the Helm values.
- For k3d, confirm `local-path` provisioner is running (`kubectl get pods -n kube-system`).

### Backups Failing
```bash
kubectl logs job/mysql-backup-<timestamp> -n mysql-dev
```
- Validate backup jobs reference the correct Secret with credentials.
- Confirm the backup target (bucket, PVC) is reachable and has permissions.
- Check CronJob schedule and history with `kubectl get cronjobs -n mysql-dev`.

---

## 🚦 Argo CD Issues

### Cannot Access the UI
```bash
kubectl port-forward svc/argocd-server -n argocd-dev 8080:443
```
- Then browse to [https://localhost:8080](https://localhost:8080). Accept the self-signed certificate if prompted.

### Forgot the Admin Password
```bash
kubectl -n argocd-dev get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d
```

### Repo Connection or Sync Failures
- Check the Application status message in the Argo CD UI or via CLI.
- Validate the repository secret contains the right SSH key or token.
- Confirm Argo CD has network access to the Git server (firewall, proxy rules).

### Application Stuck in `Unknown`
- Inspect the cluster secret:
  ```bash
  kubectl -n argocd-dev get secret argocd-cluster-config -o yaml
  ```
- Ensure the service account used by Argo CD has cluster-admin or the necessary RBAC permissions.
- Re-run `argocd cluster add` if the cluster credentials expired.

---

## 📈 Autoscaling & Metrics

### HPA Not Scaling
```bash
kubectl get hpa -A
kubectl describe hpa vyking-app-frontend -n frontend-dev
```
- Install or troubleshoot `metrics-server` if metrics are missing:
  ```bash
  kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
  ```
- Ensure resource requests are set on the deployment; HPAs ignore pods without CPU/memory requests.

### CPU/Memory Metrics Missing in Grafana/Monitoring
- Confirm Prometheus or metrics-stack pods are running.
- Check scrape configs include the namespace.
- For k3d, allocate enough memory to the Docker VM to handle metric retention.

---

## 🔍 Debug Command Cheat Sheet

```bash
# Switch to a namespace
kubectl config set-context --current --namespace=<ns>

# Inspect all resources in a namespace
kubectl get all -n <ns>

# Describe a failing pod
kubectl describe pod <pod-name> -n <ns>

# Tail container logs
kubectl logs <pod-name> -n <ns> --tail=100

# Watch rollout status
kubectl rollout status deploy/<deployment-name> -n <ns>

# Stream events
kubectl get events -n <ns> --watch
```

Keep this file updated as you encounter new failure modes. Accurate diagnostics up front save hours of guesswork later!