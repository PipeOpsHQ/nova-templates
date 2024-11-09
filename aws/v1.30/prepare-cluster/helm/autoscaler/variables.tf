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

variable "aws_region" {
  type        = string
  description = "AWS region where secrets are stored."
}


variable "k8_config" {
  type        = string
  description = "Path to current kube-config"
}

variable "k8s_namespace" {
  type        = string
  default     = "cluster-autoscaler"
  description = "The K8s namespace in which the node-problem-detector service account has been created"
}

variable "helm_chart_name" {
  type        = string
  default     = "cluster-autoscaler"
  description = "Helm chart name to be installed"
}

variable "helm_chart_version" {
  type        = string
  default     = "9.32.1"
  description = "Version of the Helm chart"
}

variable "helm_release_name" {
  type        = string
  default     = "cluster-autoscaler"
  description = "Helm release name"
}
variable "helm_repo_url" {
  type        = string
  default     = "https://kubernetes.github.io/autoscaler"
  description = "Helm repository"
}

#variable "service_account_role_name" {
#  type        = string
#  description = "Rbac service account role name"
#}

variable "helm_create_namespace" {
  type        = bool
  default     = true
  description = "Create the namespace if it does not yet exist"
}