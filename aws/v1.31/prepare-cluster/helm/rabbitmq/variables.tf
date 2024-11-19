variable "helm_release_name" {
  description = "Helm release name"
  type = string
  default = "rabbitmq"
}

variable "helm_repo_url" {
  type        = string
  default     = "https://charts.bitnami.com/bitnami"
  description = "Helm repository"
}

variable "helm_chart_name" {
  type        = string
  default     = "rabbitmq"
  description = "Helm chart name to be installed"
}

variable "helm_chart_version" {
  type        = string
  default     = "15.0.6"
  description = "Version of the Helm chart"
}

variable "k8s_namespace" {
  type        = string
  default     = "default"
  description = "The K8s namespace where helm chart is to be installed"
}