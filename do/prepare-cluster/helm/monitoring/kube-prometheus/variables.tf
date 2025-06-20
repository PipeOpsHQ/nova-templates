
variable "helm_chart_name" {
  type        = string
  default     = "kube-prometheus-stack"
  description = "Helm chart name to be installed"
}

variable "helm_repo_url" {
  type        = string
  default     = "https://prometheus-community.github.io/helm-charts"
  description = "Helm repository"
}

variable "helm_release_name" {
  type        = string
  default     = "kube-prometheus-stack"
  description = "Helm release name"
}

variable "helm_chart_version" {
  type        = string
  default     = "65.4.0"
  description = "Version of the Helm chart"
}
variable "cluster_name" {
  type = string

}

variable "dns_zone" {
  type = string

}
