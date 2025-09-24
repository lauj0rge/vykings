[![ArgoCD Version](https://img.shields.io/badge/argo--cd-v2.11.2-EF7B4D.svg?logo=argo)](https://github.com/argoproj/argo-cd/releases/latest) [![Terraform Version](https://img.shields.io/badge/terraform-~%3E%201.8-blue?logo=terraform)](https://github.com/hashicorp/terraform/releases) [![Helm Version](https://img.shields.io/badge/helm-v3-blue?logo=helm)](https://helm.sh/) [![Kubernetes Compatible](https://img.shields.io/badge/Kubernetes-%3E%3D%201.28-326CE5.svg?logo=kubernetes)](https://kubernetes.io/) [![Sealed Secrets](https://img.shields.io/badge/Sealed--Secrets-Enabled-green)](https://github.com/bitnami-labs/sealed-secrets) [![k3d Cluster](https://img.shields.io/badge/k3d-Local%20Cluster-FF6C37?logo=kubernetes)](https://k3d.io/) [![CI Status](https://img.shields.io/github/actions/workflow/status/lauj0rge/vyking-devops-task/cicd.yml?branch=dev&label=CI%20Build)](https://github.com/lauj0rge/vyking-devops-task/actions) [![End-to-End Tests](https://img.shields.io/badge/E2E%20Tests-Passing-brightgreen)](./tests-results) [![GitOps Enabled](https://img.shields.io/badge/GitOps-Enabled-EF7B4D?logo=argo&logoColor=white)](https://argo-cd.readthedocs.io/en/stable/)

# Vyking DevOps Platform

This repository contains everything needed to build a fully automated GitOps environment for the Vyking Gaming Leaderboard experience. It packages infrastructure, application manifests, and tooling to let you spin up a local [k3d](https://k3d.io/) based Kubernetes cluster, deploy the stack through Argo CD, and validate that the environment is healthy.

The platform is intentionally split into clearly defined components so that each responsibility—from container builds to Terraform driven GitOps configuration—is easy to discover and maintain. The resulting environment renders a polished leaderboard UI backed by a Flask API and MySQL schema seeded with mock player telemetry so teams can demo end-to-end GitOps workflows without connecting to external services.

## High level architecture

```
                ┌────────────┐
                │    User    │
                └────────────┘
                        │
                        │ HTTPS
                        ▼
                ┌─────────────────────────────────────────────────┐
                │                 Ingress (k3d)                   │
                │   - Path: /       → frontend-service:80         │
                │   - Path: /api/*  → backend-service:5000        │
                │   - TLS Termination (via cert-manager)          │
                └─────────────────────────────────────────────────┘
                        │                         │
                        │ / (static assets)       │ /api/*
                        ▼                         ▼
                ┌───────────────────┐    ┌────────────────────────────┐
                │  Frontend Service │    │     Backend Service        │
                │  (NGINX Pod)      │    │     (Flask API Pod)        │
                └───────────────────┘    └─────────────┬──────────────┘
                                                       │
                                                       │ SQL (via Service)
                                                       ▼
                                            ┌────────────────────────┐
                                            │   MySQL StatefulSet    │
                                            │ - Persistent Volumes   │
                                            └────────────────────────┘
                                                       │
                                                       │ Backups
                                                       ▼
                                            ┌────────────────────────┐
                                            │   Backup CronJob       │
                                            └────────────────────────┘
                
                
                ───────────────────────────────────────────────────────────────────
                                         DEPLOYMENT LAYER
                ───────────────────────────────────────────────────────────────────
                        │                                 │
                        │                                 │
                        │                                 │
                ┌───────▼─────────────┐        ┌──────────▼──────────┐
                │     ArgoCD          │        │      Terraform      │
                │  (GitOps Operator)  │        │ (Infrastructure as  │
                │                     │        │        Code)        │
                │ - Monitors Git Repo │        │ - Provisions Cluster│
                │ - Deploys Apps      │        │ - Deploys ArgoCD    │
                │ - Syncs State       │        │ - Deploys Base Infra│
                └─────────────────────┘        └─────────────────────┘
                        │                                 │
                        │ Git Pull                        │ terraform apply
                        ▼                                 ▼
                ┌─────────────────────┐        ┌─────────────────────┐
                │   Git Repository    ◀────────┤   CI/CD Pipeline    │
                │   (This Project)    │        │  (e.g., GitHub      │
                │ - Application Manifests      │   Actions, Jenkins) │
                │ - Helm Charts       │        └─────────────────────┘
                │ - Terraform Code    │
                └─────────────────────┘
```
All Kubernetes objects represented in the diagram are rendered by the shared Helm chart at `applications/vyking-app`. The chart emits dedicated Deployments, Services, optional Ingress resources, and HPAs for both the frontend and backend so that they can be managed together while still supporting environment-specific overrides. The backend exposes `/health`, `/readiness`, and `/leaderboard` routes, the latter serving the top players ordered by win rate from the `player_leaderboard` table stored in MySQL.

Argo CD continuously reconciles the `applications/*` Helm charts and `infrastructure/*` components from this Git repository into the target cluster. Terraform modules provision Argo CD itself and register every application as an Argo CD `Application` resource, ensuring a fully GitOps-managed workflow.

## Repository layout & component responsibilities

| Path                              | Description                                 | Primary responsibilities |
|-----------------------------------|---------------------------------------------|---------------------------------------------------------------------------------------------------------------|
| `applications/backend/app`        | Flask leaderboard API and Dockerfile.       | Exposes `/leaderboard` JSON sourced from MySQL plus health/readiness endpoints. Credentials arrive via Kubernetes Secrets created from SealedSecrets. |
| `applications/backend/templates`  | Backend Helm chart templates.               | Deploys the API Deployment/Service, wires database credentials from a SealedSecret-sourced Secret, and optionally enables an HPA. |
| `applications/frontend/app`       | Static frontend assets and container build. | Renders the Vyking Arena leaderboard UI, proxies `/api` calls to the backend, and ships in an NGINX image. |
| `applications/frontend/templates` | Frontend Helm chart templates.              | Publishes the static site, injects backend routing via ConfigMap, exposes a Service/Ingress, and can scale with an HPA. |
| `applications/vyking-app`         | Umbrella Helm chart for app workloads.      | Coordinates the frontend and backend from one values file, exposing shared configuration plus optional Ingress and HPA resources for each component. |
| `infrastructure/mysql`            | Helm chart wrapper around Bitnami MySQL.    | Supplies schema bootstrap hooks, PVCs, HPA, and a CronJob backup schedule customised per environment values file. |
| `infrastructure/cert-manager`     | cert-manager manifests.                     | Creates a self-signed cluster issuer and per-environment TLS certificates for the frontend ingress. |
| `infrastructure/sealed`           | Pre-generated SealedSecrets.                | Holds sealed MySQL credentials that Argo CD applies before workloads start, keeping plaintext secrets out of git. |
| `terraform/`                      | Terraform root module.                      | Wires providers and composes the Argo CD, infrastructure, and application modules for GitOps reconciliation. |
| `terraform/modules/argocd`        | Argo CD bootstrap.                          | Installs the Argo CD Helm chart and registers the git repository as a read-only source for Applications. |
| `terraform/modules/infra`         | Cluster services GitOps.                    | Creates namespaces and Argo CD Applications for sealed secrets and MySQL, plus installs cert-manager via Helm. |
| `terraform/modules/applications`  | Frontend & backend GitOps.                  | Defines namespaces, TLS assets, and Argo CD Applications for each workload with environment-specific Helm values. |
| `scripts/`                        | Automation helpers.                         | Provide end-to-end workflow scripts for dependency setup, cluster bootstrap, smoke tests, mock data loading, and teardown. |
| `terraform/env/*.tfvars`          | Environment definitions.                    | Store per-environment namespaces, git branches, and ingress hosts consumed by Terraform modules. |

## Application charts

The frontend and backend workloads are delivered through the umbrella Helm chart located at `applications/vyking-app`. It renders both Deployments and Services from a single values file so the components can be versioned together while still letting you enable or disable either workload per environment.

Key capabilities include:

- **Configurable container images and resources** via the `frontend.*` and `backend.*` value blocks so CI can push dev/prod tags and override CPU/memory requests.
- **Ingress and autoscaling controls** surfaced through `.frontend.ingress`, `.backend.ingress`, `.frontend.hpa`, and `.backend.hpa`, letting you activate HTTP entry points or HPAs with a boolean switch and tune their thresholds.
- **Shared service wiring** such as the frontend ConfigMap that proxies `/api` calls to the backend service and the backend's MySQL secret references, all annotated with the global environment label from `global.environment`.
- **Seed data tooling** with the checked-in `scripts/mock-data.sql` file so you can load a curated leaderboard dataset into MySQL immediately after bootstrap.

## Infrastructure building blocks

- **MySQL** is delivered through the Bitnami Helm dependency with extra templates for schema bootstrap (`ConfigMap`), scheduled dumps, storage PVCs, and HPA. Environment overlays adjust credentials, storage, and backup cadence. Load `scripts/mock-data.sql` with `kubectl exec` (see below) to populate the `player_leaderboard` table for demos.
- **Sealed Secrets** manifests are kept under version control so Argo CD can decrypt them at deploy time once the controller is installed.
- **cert-manager** resources issue local TLS certificates for the frontend ingress using a self-signed ClusterIssuer.

## Terraform modules & GitOps flow

1. **`modules/argocd`** installs Argo CD and stores repository connection details inside the cluster.
2. **`modules/infra`** registers the infrastructure charts (sealed secrets + MySQL) as Argo CD `Application` CRDs so they sync automatically after Argo CD becomes ready.
3. **`modules/applications`** provisions frontend/backend namespaces, TLS certificates, and corresponding Argo CD `Application` objects for each workload.

Running `terraform apply -var-file=env/dev.tfvars` from the repo root bootstraps the whole GitOps chain against a cluster whose kubeconfig lives at `~/.kube/vyking-dev-config` (or the environment-specific path).

## Automation scripts

| Script | Purpose |  
| ------ | ------- |  
| `scripts/setup-tools.sh` | Installs Docker, kubectl 1.33.5, k3d, Helm, and Terraform on a clean Ubuntu host.|  
| `scripts/images-build.sh <env>` | Builds the frontend/backend containers locally and imports them into the k3d registry so Argo CD can deploy new tags. |  
| `scripts/cluster.sh <env>` | Creates a fresh k3d cluster (with optional load balancer ports in prod) and installs the Sealed Secrets controller. |  
| `scripts/bootstrap.sh <env>` | Full end-to-end bootstrap: validates dependencies, creates secrets, builds/imports Docker images, applies Terraform modules, opens Argo CD & ingress port-forwards, prints MySQL credentials, and captures a Markdown test report. |  
| `scripts/tests.sh <env>` | Generates a Markdown health report summarising cluster info, Argo CD apps, and workload status using collapsible sections. |  
| `scripts/cleanup.sh <env>` | Tears everything down: Terraform destroy, kill port-forwards, delete k3d cluster, and clean kubeconfig entries. |  

All scripts default to the `dev` environment when no argument is provided and rely on `scripts/secrets.env` for non-committed credentials.

## Environment configuration

Each environment is described once in Terraform (`terraform/env/*.tfvars`) and once in Helm chart value overlays (`applications/*/environments/values-*.yaml`). This keeps namespaces, docker tags, ingress hosts, and resource requests consistent across tooling.

SealedSecrets names follow the pattern `mysql-credentials-<env>` (backend namespace) and `mysql-<env>-secret` (database namespace). The bootstrap script regenerates them from local `.env` values and commits updates safely when git remotes are configured.

## HOW TO operate the stack

1. **Install prerequisites** on your workstation once: `./scripts/setup-tools.sh`.
2. **Prepare secrets** by creating file `scripts/secrets.env` with the expected variables (`DEV_DB_USER`, `PROD_DB_PASS`, etc.).
```
# /scripts/secrets.env

EXAMPLE
# ---- DEV ----
DEV_DB_ROOT_PASS=Batman1
DEV_DB_USER=devuser
DEV_DB_PASS=devpass123
DEV_DB_NAME=devdb

# ---- PROD ----
PROD_DB_ROOT_PASS=Batman1
PROD_DB_USER=produser
PROD_DB_PASS=prodpass123
PROD_DB_NAME=proddb
```
3. **Bootstrap an environment**: `./scripts/bootstrap.sh dev` (or `prod`). The script builds/imports the Docker images, runs Terraform targets, and starts local port-forwards for Argo CD and ingress.
4. **(Optional) Seed mock data** by executing `scripts/mock-data.sql` against the MySQL primary once the StatefulSet is ready. A one-liner is:
   ```bash
   kubectl exec -i statefulset/mysql -n mysql -- mysql -u"$DEV_DB_USER" -p"$DEV_DB_PASS" "$DEV_DB_NAME" < scripts/mock-data.sql
   ```
   Adjust credentials and namespace per environment. The dataset instantly populates the leaderboard UI.
5. **Review the generated report** in `tests-results-<env>-<timestamp>.md` for a snapshot of cluster health.
6. **Tear down** when finished: `./scripts/cleanup.sh dev`.

## Useful endpoints

- **Argo CD UI:** forwarded to http://frontend-dev.local:8080  and 8080/8443 load balancer bindings in prod clusters.
- **Frontend Ingress:** https://frontend-dev.local:30443 or  https://frontend-prod.local:30443 for prod
- **Backend API:** available inside the cluster at the `backend` Service (default `ClusterIP` on port 8081) with `/health`, `/readiness`, and `/leaderboard` routes exposing the mock player leaderboard dataset.
- **Test results:** Markdown health reports are saved under [test-results/](./test-results/) after running the bootstrap/tests workflow.
