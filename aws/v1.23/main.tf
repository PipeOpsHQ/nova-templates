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

variable "cluster_region" {
  description = "cluster region"
}

variable "cluster_vpcu" {
  description = "cluster vcpu"
  type = number
}

variable "cluster_memory" {
  description = "cluster memory"
  type = number
}

variable "cluster_storage" {
  description = "cluster storage"
  type = number
}

variable "kubernetes_version" {
  type        = string
  default     = "1.25"
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version is used"
}

variable "cluster_gpu_type" {
  description = "cluster gpu type"
  type = bool
}

variable "cluster_default_node" {
  description = "cluster default node"
  type = number
}

variable "cluster_min_node" {
  description = "cluster min node"
  type = number
}

variable "cluster_max_node" {
  description = "cluster max node"
  type = number
}

variable "cluster_package" {
  description = "cluster package"
}

variable "eks_instance_class" {
  description = "machine type to be used"
  default = {
    dev = "t3a.large"
    pro  = "m5.large"
    startup  = "c5a.2xlarge"
  }
}

variable "aws_config" {
  description = "path to aws config"
  type = string
}


data "aws_iam_role" "existing-eks-role" {
  name = "pipeops-eks-cluster-role"
}

data "aws_iam_role" "existing-node-role" {
  name = "pipeops-eks-node-role"
}

data "aws_vpc" "selected" {
  tags = {
    Name = "${var.pipeops_aws_account}-vpc"
  }
}

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}


