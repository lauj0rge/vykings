output "argocd_namespace" {
  value       = module.argocd.namespace
  description = "Namespace where Argo CD is running"
}

output "argocd_release_name" {
  value       = module.argocd.release_name
  description = "Helm release name of Argo CD"
}

output "mysql_name" {
  description = "Name of the Argo CD Application resource for infrastructure"
  value       = module.infra.mysql_app_name
}

