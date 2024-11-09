variable "helm_release_name" {
  description = "Helm release name"
  type = string
  default = "opencost"
}

variable "helm_repo_url" {
  type        = string
  default     = "https://opencost.github.io/opencost-helm-chart"
  description = "Helm repository"
}

variable "helm_chart_name" {
  type        = string
  default     = "opencost"
  description = "Helm chart name to be installed"
}

variable "helm_chart_version" {
  type        = string
  default     = "1.41.0"
  description = "Version of the Helm chart"
}

variable "k8s_namespace" {
  type        = string
  default     = "default"
  description = "The K8s namespace where helm chart is to be installed"
}