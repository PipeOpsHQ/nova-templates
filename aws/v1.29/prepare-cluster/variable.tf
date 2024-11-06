variable "k8_config" {
  description = "path to k8 config"
  type = string
  default = "~/Work/PipeOps/nova-tf-templates/k8-config.yml"
}

variable "eks_cluster_name" {
  description = "cluster name"
  default = "pipeops"
}

variable "cluster_package" {
  description = "cluster package"
  default = "t3.medium"
}

variable "bucket_name" {
  description = "Name of S3 bucket to store loki data"
  default = "grafana-loki-pipeops"  
}

variable "aws_config_path" {
  description = "path to aws config"
  type = list(string)
  default =[ "~/.aws/credentials"]
}

variable "aws_profile" {
  description = "AWS PROFILE"
  default = "default"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default = "eu-west-2"
}

variable "dns_zone" {
  description = "DNS_Zone for all created addons"
  default = "pipeops.co"
}

