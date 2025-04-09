variable "do_token" {
  type    = string

}

variable "vpc_name" {
  description = "Name of VPC"
  type = string
  default = "pipeops-altschool-vpc"
}

variable "cluster_name" {
  description = "Name of the DOKS cluster"
  type        = string
  default     = "pipeops-altschool"
}

variable "region" {
  description = "Region where the DOKS cluster will be created"
  type        = string
  default     = "lon1"
}

variable "k8s_version" {
  description = "Kubernetes version for the DOKS cluster"
  type        = string
  default     = "1.30.9-do.0"
}

variable "node_size" {
  description = "Size of the worker nodes"
  type        = string
  default     = "s-2vcpu-4gb"
}

variable "node_count" {
  description = "Number of worker nodes in the cluster"
  type        = number
  default     = 2
}
