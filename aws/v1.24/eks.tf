module "eks_sec_group" {
  source           = "./eks/eks_sec_group"
  eks_cluster_name = var.eks_cluster_name
  vpc_id           = data.aws_vpc.selected.id
  AWS_PROFILE      = var.AWS_PROFILE
}

#module "ecr_repo" {
#  source = "./eks/ecr"
#  workspace = var.pipeops_aws_account
#  eks_cluster_name = var.eks_cluster_name
#}

module "eks_cluster" {
  source           = "./eks/eks_cluster"
  eks_cluster_name = var.eks_cluster_name
  iam_cluster_arn  = data.aws_iam_role.existing-eks-role.arn
  iam_node_arn     = data.aws_iam_role.existing-node-role.arn
  aws_region       = var.aws_region
  aws_profile      = var.AWS_PROFILE
  workspace        = var.pipeops_aws_account
  eks_version      = local.sanitized_kubernetes_version

  subnets = data.aws_subnets.selected.ids

  security_group_cluster = module.eks_sec_group.security_group_cluster
}

locals {
  sanitized_kubernetes_version = replace(var.kubernetes_version, "v", "")
}

# Generate a random vm name
resource "random_string" "random-name" {
  length  = 8
  special = false
  upper   = false
  numeric = false
}

#resource "aws_key_pair" "terra" {
#  key_name   = random_string.random-name.result
#  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
#}

module "eks_node" {
  source = "./eks/eks_node"

  name                  = var.eks_cluster_name
  instance_types        = [var.cluster_package]
  node_role_arn         = [data.aws_iam_role.existing-node-role.arn]
  subnet_ids            = data.aws_subnets.selected.ids
  desired_size          = var.cluster_default_node
  min_size              = var.cluster_min_node
  max_size              = var.cluster_max_node
  cluster_name          = var.eks_cluster_name
  create_before_destroy = true
  kubernetes_version    = local.sanitized_kubernetes_version == null || local.sanitized_kubernetes_version == "" ? [] : [local.sanitized_kubernetes_version]

#  after_cluster_joining_userdata = var.after_cluster_joining_userdata

  #  ec2_ssh_key_name      = [aws_key_pair.terra.key_name]
  ami_type            = var.ami_type
  ami_release_version = var.ami_release_version

#  before_cluster_joining_userdata = [var.before_cluster_joining_userdata]


  block_device_mappings = [
    {
      "delete_on_termination" : true,
      "device_name" : "/dev/xvda",
      "encrypted" : true,
      "volume_size" : var.cluster_storage,
      "volume_txype" : "gp2"
    }
  ]
  capacity_type         = "ON_DEMAND"


  # Enable the Kubernetes cluster auto-scaler to find the auto-scaling group
  cluster_autoscaler_enabled = true

  node_group_terraform_timeouts = [{
    create = "40m"
    update = null
    delete = "20m"
  }]
}



module "addons" {
  source           = "./eks/addons"
  eks_cluster_name = var.eks_cluster_name
}

variable "eks_cluster_name" {
  description = "cluster name"
  default = "test"
}

variable "ami_type" {
  type        = string
  description = <<-EOT
    Type of Amazon Machine Image (AMI) associated with the EKS Node Group.
    Defaults to `AL2_x86_64`. Valid values: `AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM, BOTTLEROCKET_ARM_64, BOTTLEROCKET_x86_64, BOTTLEROCKET_ARM_64_NVIDIA, BOTTLEROCKET_x86_64_NVIDIA, WINDOWS_CORE_2019_x86_64, WINDOWS_FULL_2019_x86_64, WINDOWS_CORE_2022_x86_64, WINDOWS_FULL_2022_x86_64`.
    EOT
  default     = "AL2_x86_64"
  validation {
    condition = (
    contains(["AL2_x86_64", "AL2_x86_64_GPU", "AL2_ARM_64", "CUSTOM", "BOTTLEROCKET_ARM_64", "BOTTLEROCKET_x86_64", "BOTTLEROCKET_ARM_64_NVIDIA", "BOTTLEROCKET_x86_64_NVIDIA", "WINDOWS_CORE_2019_x86_64", "WINDOWS_FULL_2019_x86_64", "WINDOWS_CORE_2022_x86_64", "WINDOWS_FULL_2022_x86_64"], var.ami_type)
    )
    error_message = "Var ami_type must be one of \"AL2_x86_64\",\"AL2_x86_64_GPU\",\"AL2_ARM_64\",\"BOTTLEROCKET_ARM_64\",\"BOTTLEROCKET_x86_64\",\"BOTTLEROCKET_ARM_64_NVIDIA\",\"BOTTLEROCKET_x86_64_NVIDIA\",\"WINDOWS_CORE_2019_x86_64\",\"WINDOWS_FULL_2019_x86_64\",\"WINDOWS_CORE_2022_x86_64\",\"WINDOWS_FULL_2022_x86_64\", or \"CUSTOM\"."
  }
}


variable "ami_release_version" {
  type        = list(string)
  default     = []
  description = "EKS AMI version to use, e.g. For AL2 \"1.16.13-20200821\" or for bottlerocket \"1.2.0-ccf1b754\" (no \"v\") or  for Windows \"2023.02.14\". For AL2, bottlerocket and Windows, it defaults to latest version for Kubernetes version."
  validation {
    condition = (
    length(var.ami_release_version) == 0 ? true : length(regexall("(^\\d+\\.\\d+\\.\\d+-[\\da-z]+$)|(^\\d+\\.\\d+\\.\\d+$)", var.ami_release_version[0])) == 1
    )
    error_message = "Var ami_release_version, if supplied, must be like for AL2 \"1.16.13-20200821\" or for bottlerocket \"1.2.0-ccf1b754\" (no \"v\") or for Windows \"2023.02.14\"."
  }
}
