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
  default     = "pipeops"
}

variable "pipeops_workspace_account" {
  description = "PipeOps WorkSpace Name"
  default = "test"
}

variable "eks_version" {
  description = "PipeOps Cluster Version"
  default     = "1.31"
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
