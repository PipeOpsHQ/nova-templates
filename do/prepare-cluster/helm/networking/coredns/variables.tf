variable "enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether deployment is enabled."
}

variable "k8s_namespace" {
  type        = string
  default     = "kube-system"
  description = "The K8s namespace in which the node-problem-detector service account has been created"
}

variable "helm_chart_name" {
  type        = string
  default     = "coredns"
  description = "Helm chart name to be installed"
}

variable "helm_chart_version" {
  type        = string
  default     = "1.28.2"
  description = "Version of the Helm chart"
}

variable "helm_release_name" {
  type        = string
  default     = "capsule-proxy"
  description = "Helm release name"
}
variable "helm_repo_url" {
  type        = string
  default     = "https://coredns.github.io/helm"
  description = "Helm repository"
}

variable "helm_create_namespace" {
  type        = bool
  default     = true
  description = "Create the namespace if it does not yet exist"
}
