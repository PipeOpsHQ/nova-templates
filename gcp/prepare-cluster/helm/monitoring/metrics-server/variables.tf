variable "enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether deployment is enabled."
}

variable "helm_chart_name" {
  type        = string
  default     = "metrics-server"
  description = "Metrics Server Helm chart name to be installed"
}

variable "helm_chart_release_name" {
  type        = string
  default     = "metrics-server"
  description = "Helm release name"
}

variable "helm_chart_version" {
  type        = string
  default     = "3.12.1"
  description = "Metrics Server Helm chart version."
}

variable "helm_chart_repo" {
  type        = string
  default     = "https://kubernetes-sigs.github.io/metrics-server/"
  description = "Metrics Server repository name."
}

variable "namespace" {
  type        = string
  default     = "kube-system"
  description = "Kubernetes namespace to deploy Metrics Server Helm chart."
}