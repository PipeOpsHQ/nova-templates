variable "k8_config" {
  description = "path to k8 config"
  type = string
  default = "/home/toluwalope/Work/PipeOps/nova-tf-templates/aws/v1.29/k8-config.yml" 
}

variable "eks_cluster_name" {
  description = "cluster name"
  default = "pipeops-cluster"

}

variable "cluster_package" {
  description = "cluster package"
  default = "t3a-medium"
}

variable "aws_config_path" {
  description = "path to aws config"
  type = string
  default = "~/.aws/config"
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

