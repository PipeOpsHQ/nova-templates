variable "subscription_id" {
  type = string
  default = "f18d01a6-5d47-4be7-9765-6b456b90df09"
}

variable "resource_group_name" {
  type = string
  default = "sre-test"
}

variable "resource_group_location" {
  type = string
  default = "East US"
}

variable "vnet_name" {
  type = string
  default = "pipeops-network"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "dns_servers_ip" {
  description = "IP address for DNS Servers"
  type = list(string)
  default = ["10.0.0.4", "10.0.0.5"]
}

variable "cluster_name" {
  description = "Name of Cluster"
  type        = string
  default     = "pipeops"
}

variable "pipeops_subnet_1_name" {
  description = "Name of public subnet"
  type = string
  default = "pipeops-subnet-1"
}

variable "pipeops_subnet_2_name" {
  description = "Name of public subnet"
  type = string
  default = "pipeops-subnet-2"
}

variable "pipeops_subnet_3_name" {
  description = "Name of public subnet"
  type = string
  default = "pipeops-subnet-3"
}

variable "pipeops_subnet_1_cidr" {
  description = "Public Subnet CIDR"
  type = list(string)
  default = ["10.0.0.0/20"]
}

variable "pipeops_subnet_2_cidr" {
  description = "Public Subnet CIDR"
  type = list(string)
  default = ["10.0.16.0/20"]
}

variable "pipeops_subnet_3_cidr" {
  description = "Private Subnet CIDR"
  type = list(string)
  default = ["10.0.32.0/20"]
}

