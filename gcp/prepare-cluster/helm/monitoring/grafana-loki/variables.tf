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
variable "cluster_name" {
  type = string

}

variable "dns_zone" {
  type = string

}

variable "aws_access_key_s3" {
  description = "Access Key to AWS acc where the s3 bucket is created"

}

variable "aws_secret_key_s3" {
  description = "Secret Key to AWS acc where the s3 bucket is created"

}

variable "aws_region_S3" {
  description = "Region where s3 bucket is created"

}