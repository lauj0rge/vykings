variable "environment" {}
variable "repo_url" {}
variable "repo_branch" { default = "main" }
variable "frontend_namespace" { default = "frontend-dev" }
variable "backend_namespace" { default = "backend-dev" }
variable "argocd_namespace" {}
variable "frontend_host" {}
