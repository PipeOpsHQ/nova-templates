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
  default     = "pipeops-cluster"
}

variable "pipeops_workspace_account" {
  description = "PipeOps WorkSpace Name"
  default = "sre-test"
}
/*
variable "eks_version" {
  description = "PipeOps Cluster Version"
  default     = "1.28"
}
*/

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

variable "pipeops_workspace" {
  description = "PipeOps WorkSpace Account"
  default = "sre-test"
}

variable "eks_version" {
  type        = string
  default     = "1.30"
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version is used"
}

variable "cluster_name" {
  description = "Name of Cluster"
  type        = string
  default     = "pipeops-cluster"
}

variable "ami_type" {
  type    = string
  default = "AL2_x86_64"
}

variable "eks_cluster_desired_node" {
  description = "cluster default node"
  type = number
  default = 2
}

variable "eks_min_node" {
  description = "cluster min node"
  type = number
  default = 1
}

variable "eks_max_node" {
  description = "cluster max node"
  type = number
  default = 3
}

variable "eks_instance_class" {
  description = "machine type to be used"
  default = ["t3a.medium"]
  /*
  default = {
    dev = "t3a.large"
    pro  = "m5.large"
    startup  = "c5a.2xlarge"
  }*/
}

variable "eks_cluster_storage" {
  description = "cluster storage"
  type = number
  default = 10
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}