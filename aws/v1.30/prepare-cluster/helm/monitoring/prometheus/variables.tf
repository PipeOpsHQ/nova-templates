variable "enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether deployment is enabled."
}

variable "aws_provider" {
  type        = string
  default     = "aws"
  description = "Variable indicating cloud provider"
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
}

variable "k8s_namespace" {
  type        = string
  default     = "monitoring"
  description = "The K8s namespace in which the node-problem-detector service account has been created"
}

variable "helm_chart_name" {
  type        = string
  default     = "prometheus"
  description = "Helm chart name to be installed"
}

variable "helm_chart_version" {
  type        = string
  default     = "24.5.0"
  description = "Version of the Helm chart"
}

variable "helm_release_name" {
  type        = string
  default     = "prometheus"
  description = "Helm release name"
}
variable "helm_repo_url" {
  type        = string
  default     = "https://prometheus-community.github.io/helm-charts"
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

variable "dns_zone" {
  default = "pipeops.co"
}