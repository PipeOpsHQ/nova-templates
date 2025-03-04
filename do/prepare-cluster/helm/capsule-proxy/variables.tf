variable "enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether deployment is enabled."
}

variable "k8s_namespace" {
  type        = string
  default     = "capsuleproxy"
  description = "The K8s namespace in which the node-problem-detector service account has been created"
}

variable "helm_chart_name" {
  type        = string
  default     = "capsule-proxy"
  description = "Helm chart name to be installed"
}

variable "helm_chart_version" {
  type        = string
  default     = "0.6.0"
  description = "Version of the Helm chart"
}

variable "helm_release_name" {
  type        = string
  default     = "capsule-proxy"
  description = "Helm release name"
}
variable "helm_repo_url" {
  type        = string
  default     = "https://projectcapsule.github.io/charts/"
  description = "Helm repository"
}

variable "helm_create_namespace" {
  type        = bool
  default     = true
  description = "Create the namespace if it does not yet exist"
}

variable "cluster_name" {
  type        = string
}
