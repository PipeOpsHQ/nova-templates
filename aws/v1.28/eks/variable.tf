variable "pipeops_workspace" {
  description = "PipeOps WorkSpace Account"
}

variable "eks_version" {
  type        = string
  default     = "1.28"
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version is used"
}

variable "cluster_name" {
  description = "Name of Cluster"
  type        = string
}

variable "eks_cluster_desired_node" {
  description = "cluster default node"
  type        = number
  default     = 3
}

variable "eks_min_node" {
  description = "cluster min node"
  type        = number
  default     = 2
}

variable "eks_max_node" {
  description = "cluster max node"
  type        = number
  default     = 6
}

variable "eks_instance_class" {
  type = string
  description = "machine type to be used"
  default     = "t3.small"
}

variable "eks_cluster_storage" {
  description = "cluster storage"
  type        = number
  default     = 10
}

variable "aws_region" {
  description = "AWS region to launch servers."
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_session_token" {}
