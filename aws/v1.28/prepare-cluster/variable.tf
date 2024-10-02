variable "k8_config" {
  description = "path to k8 config"
  type = string
}

variable "eks_cluster_name" {
  description = "cluster name"
}

variable "cluster_package" {
  description = "cluster package"
}

variable "aws_config_path" {
  description = "path to aws config"
  type = string
}

variable "aws_profile" {
  description = "AWS PROFILE"
}

variable "aws_region" {
  description = "AWS region to launch servers."
}

variable "dns_zone" {
  description = "DNS_Zone for all created addons"
  default = "pipeops.co"
}

