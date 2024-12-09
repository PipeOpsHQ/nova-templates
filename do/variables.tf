variable "do_token" {
  type    = string
  default = ""
}

variable "vpc_name" {
  description = "Name of VPC"
  type = string
  default = "pipeops-vpc"
}
variable "create_cluster" {
  description = "Specifies whether a cluster should be created"
  type        = bool
  default     = false
}

variable "cluster_name" {
  description = "Name of the DOKS cluster"
  type        = string
  default     = "pks-lon1"
}

variable "region" {
  description = "Region where the DOKS cluster will be created"
  type        = string
  default     = "lon1"
}

variable "k8s_version" {
  description = "Kubernetes version for the DOKS cluster"
  type        = string
  default     = "1.29.9-do.4"
}

variable "node_size" {
  description = "Size of the worker nodes"
  type        = string
  default     = "s-4vcpu-16gb-amd"
}

variable "node_count" {
  description = "Number of worker nodes in the cluster"
  type        = number
  default     = 3
}

variable "bucket_name" {
  description = "Name of S3 bucket to store loki data"
  default     = "grafana-loki-pipeops"
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