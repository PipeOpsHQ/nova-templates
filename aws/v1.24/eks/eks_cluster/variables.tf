variable "eks_cluster_name" {}

variable "iam_cluster_arn" {}

variable "iam_node_arn" {}

variable "subnets" {
  type = list
}

variable "security_group_cluster" {}

variable "aws_region" {}

variable "aws_profile" {}

variable "workspace" {}

variable "eks_version" {
  type = string
  default = "1.24"
  description = "Eks Master Version"
}
