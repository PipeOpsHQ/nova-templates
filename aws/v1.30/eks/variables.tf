variable "pipeops_workspace" {
  description = "PipeOps WorkSpace Account"
  default     = "test"
}

variable "eks_version" {
  type        = string
  default     = "1.30"
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version is used"
}

variable "cluster_name" {
  description = "Name of Cluster"
  type        = string
  default     = "pipeops"
}

variable "eks_cluster_desired_node" {
  description = "cluster default node"
  type        = number
  default     = 2
}

variable "eks_min_node" {
  description = "cluster min node"
  type        = number
  default     = 1
}

variable "eks_max_node" {
  description = "cluster max node"
  type        = number
  default     = 3
}

variable "eks_instance_class" {
  description = "machine type to be used"
  type        = list(string)
  # default     = ["t3a.large"]
  /*
  default = {
    dev     = "t3a.large"
    pro     = "m5.large"
    startup = "c5a.2xlarge"
  } */
}

variable "ami_type" {
  type    = string
  default = "AL2_x86_64"
}


variable "eks_cluster_storage" {
  description = "cluster storage"
  type        = number
  default     = 10
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

variable "install_karpenter" {
  type        = bool
  description = "To install karpenter or not"
  default     = false
}


variable "aws_config_path" {
  description = "path to aws config"
  type        = string

}

variable "aws_profile" {
  description = "AWS PROFILE"

}

variable "aws_region" {
  description = "AWS region to launch servers."

}

variable "ecr_region" {
  description = "AWS region for Public ECR Authentication"
  default     = "us-east-1"
}
