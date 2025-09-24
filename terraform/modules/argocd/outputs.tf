output "namespace" {
  description = "Namespace where Argo CD is installed"
  value       = var.argocd_namespace
}

output "release_name" {
  description = "Helm release name for Argo CD"
  value       = helm_release.argocd.name
}

output "chart_version" {
  description = "Version of the Argo CD Helm chart"
  value       = helm_release.argocd.version
}

output "argocd_server_service" {
  description = "Service name for the Argo CD API/UI"
  value       = "argocd-server"
}
