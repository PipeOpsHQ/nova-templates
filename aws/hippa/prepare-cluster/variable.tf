variable "AWS_PROFILE" {
  description = "AWS PROFILE"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-1"
}

variable "k8_config" {
  description = "path to k8 config"
  type = string
}

variable "aws_config" {
  description = "path to aws config"
  type = string
}

variable "eks_cluster_name" {
  description = "cluster name"
}

variable "cluster_package" {
  description = "cluster package"
}
