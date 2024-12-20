variable "project_id" {
  type = string

}

variable "region" {
  type = string

}

variable "cluster_name" {
  type = string

}
variable "service_account_ns" {
  type = string
  description = "Namespace to create pipeops admin service account"
  default = "pipeops"
}

variable "bucket_name" {
  description = "Name of S3 bucket to store loki data"
  default     = "grafana-loki-pipeops-s3"
}

variable "install_cert_manager" {
  type = bool
  description = "To install cert manager or not"
  default = true
}

variable "install_ingress_controller" {
  type = bool
  description = "To install Nginx ingress controller"
  default = true
}

variable "install_k8s_dashboard" {
  type = bool
  description = "To install Kubernetes dashboard or not"
  default = true
}

variable "install_grafana_loki" {
  type = bool
  description = "To install Grafana Loki or not"
  default = true
}

variable "install_opencost" {
  type = bool
  description = "To install opencost"
  default = true
}

variable "install_kube_prometheus_stack" {
  type = bool
  description = "To install kube prom stack or not"
  default = true
}

variable "aws_config_path" {
  description = "path to aws config"
  type        = list(string)
  default     = ["~/.aws/credentials"]
}

variable "aws_profile" {
  description = "AWS PROFILE"
  default     = "default"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "eu-west-2"
}