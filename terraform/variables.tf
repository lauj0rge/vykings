variable "environment" {}
variable "repo_url" {}
variable "repo_branch" {}
variable "kubeconfig_path" { default = "~/.kube/config" }
variable "argocd_namespace" {}
variable "frontend_namespace" {}
variable "backend_namespace" {}
variable "mysql_namespace" {}
variable "frontend_host" {}
