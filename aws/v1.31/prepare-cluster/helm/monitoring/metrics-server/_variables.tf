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
  default     = "7.3.0"
  description = "Metrics Server Helm chart version."
}

variable "helm_chart_repo" {
  type        = string
  default     = "oci://registry-1.docker.io/bitnamicharts"
  description = "Metrics Server repository name."
}


variable "namespace" {
  type        = string
  default     = "monitoring"
  description = "Kubernetes namespace to deploy Metrics Server Helm chart."
}

variable "k8_config" {
  description = "path to k8 config"
  type = string

}

variable "cluster_package" {
  description = "Package a cluster belongs to"
  type = string

}