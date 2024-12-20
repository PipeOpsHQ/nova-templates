variable "eks_cluster_name" {
  description = "cluster name"
}

variable "cluster_package" {
  description = "cluster package"
}

variable "aws_profile" {
  description = "AWS PROFILE"
}

variable "aws_region" {
  description = "AWS region to launch servers."
}

variable "dns_zone" {
  description = "DNS_Zone for all created addons"
  default     = "pipeops.co"
}

variable "service_account_ns" {
  type        = string
  description = "Namespace to create pipeops admin service account"
  default     = "pipeops"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_session_token" {}
