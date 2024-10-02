## Network
# Create VPC
module "vpc" {
  source           = "./vpc"
  eks_cluster_name = var.eks_cluster_name
  workspace_name   = var.pipeops_aws_account
  cidr_block       = var.cidr_block
  aws_region       = var.aws_region
  AWS_PROFILE = var.AWS_PROFILE
}

variable "cidr_block" {
  description = "CIDR for the whole VPC"

  default = {
    prod = "10.10.0.0/16"
    default  = "10.20.0.0/16"
  }
}
