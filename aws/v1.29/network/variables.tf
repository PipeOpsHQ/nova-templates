variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnets_cidrs" {
  description = "Private Subnets CIDR"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets_cidrs" {
  description = "Public Subnets CIDR"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "intra_subnets_cidrs" {
  description = "Public Subnets CIDR"
  type        = list(string)
  default     = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]
}

variable "eks_cluster_name" {
  description = "Name of Cluster"
  type        = string
  default     = "pipeops-network-1"
}

variable "pipeops_workspace_account" {
  description = "PipeOps WorkSpace Name"
}

variable "eks_version" {
  description = "PipeOps Cluster Version"
  default     = "1.28"
}

variable "aws_region" {
  description = "AWS region to launch servers."
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_session_token" {}
