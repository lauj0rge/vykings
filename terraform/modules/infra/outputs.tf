output "mysql_app_name" {
  description = "Name of the Argo CD Application resource for infrastructure"
  value       = kubernetes_manifest.mysql.manifest.metadata.name
}

output "repo_url" {
  description = "Git repository URL used by Argo CD Applications"
  value       = var.repo_url
}

output "repo_branch" {
  description = "Git branch used by Argo CD Applications"
  value       = var.repo_branch
}
