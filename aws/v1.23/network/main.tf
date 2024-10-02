terraform {
  backend "s3" {
    bucket         = "<replaceAccountID>-owned-by-pipeops-do-not-delete"
    key            = "<replaceKey>-tf-state"
    region         = "eu-west-2"
    encrypt        = true
  }
}

# specify the provider and access details
provider "aws" {
  shared_credentials_files = [var.aws_config]  # Use shared_credentials_files instead
  profile                  = var.AWS_PROFILE
  region                   = var.aws_region
}


variable "AWS_PROFILE" {
  description = "AWS PROFILE"
}

variable "aws_region" {
  description = "AWS region to launch servers."
}

variable "pipeops_aws_account" {
  description = "PipeOps WorkSpace Account"
}

variable "eks_cluster_name" {
  description = "Cluster name"
  default = "test"
}

variable "aws_config" {
  description = "path to aws config"
  type = string
}