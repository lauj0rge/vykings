resource "kubernetes_namespace" "frontend" {
  metadata {
    name = var.frontend_namespace
  }
}

resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.11.1"

  namespace        = "ingress-nginx"
  create_namespace = true
  timeout          = 1200

  set {
    name  = "controller.service.type"
    value = "NodePort"
  }
  set {
    name  = "controller.service.nodePorts.http"
    value = "30080"
  }
  set {
    name  = "controller.service.nodePorts.https"
    value = "30443"
  }
}
resource "kubernetes_manifest" "frontend_app" {
  depends_on = [kubernetes_namespace.frontend]

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "frontend"
      namespace = var.argocd_namespace
      labels = {
        environment = var.environment
        part_of     = "vyking-app"
        component   = "frontend"
      }
    }
    spec = {
      project = "default"
      source = {
        repoURL        = var.repo_url
        targetRevision = var.repo_branch
        path           = "applications/vyking-app"
        helm = {
          releaseName = "frontend"
          valueFiles  = ["environments/values-frontend-${var.environment}.yaml"]
          parameters = [
            {
              name  = "frontend.image.repository"
              value = "vyking-frontend"
            },
            {
              name  = "frontend.image.tag"
              value = var.environment
            },
            {
              name  = "frontend.image.pullPolicy"
              value = "IfNotPresent"
            }
          ]
        }
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = var.frontend_namespace
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
      }
    }
  }
}
