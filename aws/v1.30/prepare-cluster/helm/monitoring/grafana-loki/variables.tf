variable "helm_release_name" {
  type        = string
  default     = "grafana-loki"
  description = "Helm release name"
}

variable "helm_repo_url" {
  type        = string
  default     = "oci://registry-1.docker.io/bitnamicharts"
  description = "Helm repository"
}

variable "helm_chart_name" {
  type        = string
  default     = "grafana-loki"
  description = "Helm chart name to be installed"
}


variable "helm_chart_version" {
  type        = string
  default     = "4.6.21"
  description = "Version of the Helm chart"
}


variable "k8s_namespace" {
  type        = string
  default     = "default"
  description = "The K8s namespace in which the helm chart is installed"
}

variable "bucket_name" {
  description = "Name of S3 bucket to store loki data"
  default = "grafana-loki-pipeops"  
}

variable "eks_cluster_name" {
  description = "cluster name"
  default = "pipeops"
}

variable "grafana-loki-host" {
  type = string
}