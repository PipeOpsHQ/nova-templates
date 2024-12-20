variable "enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether deployment is enabled."
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
  default = "pipeops-tests"
}
/*
variable "k8_config" {
  type        = string
  description = "Path to current kube-config"
}
*/
variable "k8s_namespace" {
  type        = string
  default     = "monitoring"
  description = "The K8s namespace in which the node-problem-detector service account has been created"
}

variable "helm_chart_name" {
  type        = string
  default     = "kubernetes-dashboard"
  description = "Helm chart name to be installed"
}

variable "helm_chart_version" {
  type        = string
  default     = "20.0.1"
  description = "Version of the Helm chart"
}

variable "helm_release_name" {
  type        = string
  default     = "kubernetes-dashboard"
  description = "Helm release name"
}

variable "helm_repo_url" {
  type        = string
  default     = "https://kubernetes.github.io/dashboard/"
  description = "Helm repository"
}

variable "helm_create_namespace" {
  type        = bool
  default     = true
  description = "Create the namespace if it does not yet exist"
}

variable "kubernetes_secret_name" {
  default = "basic-auth"
  description = "Name of the basic auth secret to create."
  type = string
}

# Define variables
variable "k8s_dashboard_version" {
  default = "6.0.8"
}

variable "namespace" {
  default = "kube-system"
}

variable "dns_zone" {
  default = "pipeops.dev"
}