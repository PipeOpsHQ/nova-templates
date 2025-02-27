variable "eks_cluster_name" {
  description = "cluster name"
  default     = "pipeops"
}

variable "cluster_package" {
  description = "cluster package"
  default     = "t3.medium"
}

variable "bucket_name" {
  description = "Name of S3 bucket to store loki data"
  default     = "grafana-loki-pipeops"
}

variable "install_cert_manager" {
  type        = bool
  description = "To install cert manager or not"
  default     = true
}

variable "install_k8s_dashboard" {
  type        = bool
  description = "To install Kubernetes dashboard or not"
  default     = true
}

variable "install_grafana_loki" {
  type        = bool
  description = "To install Grafana Loki or not"
  default     = true
}

variable "install_prometheus" {
  type        = bool
  description = "To install prometheus"
  default     = false
}

variable "install_kube_prometheus_stack" {
  type        = bool
  description = "To install kube prom stack or not"
  default     = true
}

variable "install_autoscaler" {
  type        = bool
  description = "To install Cluster Autoscaler"
  default     = true
}

variable "install_metrics_server" {
  type        = bool
  description = "To install metrics server"
  default     = true
}

variable "install_ingress_controller" {
  type        = bool
  description = "To install Nginx ingress controller"
  default     = true
}

variable "install_opencost" {
  type        = bool
  description = "To install opencost"
  default     = true
}

variable "install_rabbitmq" {
  type = bool
  description = "To install rabbitmq"
  default = false
}

variable "service_account_ns" {
  type = string
  description = "Namespace to create pipeops admin service account"
  default = "pipeops"
}

# variable "aws_config_path" {
#   description = "path to aws config"
#   type        = list(string)

# }

# variable "aws_profile" {
#   description = "AWS PROFILE"

# }

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "eu-west-2"
}

variable "dns_zone" {
  description = "DNS_Zone for all created addons"
  default     = "pipeops.co"
}

