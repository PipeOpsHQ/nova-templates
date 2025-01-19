variable "subscription_id" {
  type = string

}

variable "resource_group_name" {
  type = string

}

variable "resource_group_location" {
  type = string

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

}

variable "pipeops_subnet_1_cidr" {
  description = "Public Subnet CIDR"
  type = list(string)
  default = ["10.0.1.0/24"]
}

variable "pipeops_subnet_2_cidr" {
  description = "Public Subnet CIDR"
  type = list(string)
  default = ["10.0.2.0/24"]
}

variable "pipeops_subnet_3_cidr" {
  description = "Private Subnet CIDR"
  type = list(string)
  default = ["10.0.3.0/24"]
}

variable "pipeops_subnet_4_cidr" {
  description = "Private Subnet CIDR"
  type = list(string)
  default = ["10.0.4.0/24"]
}

variable "pipeops_subnet_5_cidr" {
  description = "Private Subnet CIDR"
  type = list(string)
  default = ["10.0.5.0/24"]
}

variable "pipeops_subnet_6_cidr" {
  description = "Private Subnet CIDR"
  type = list(string)
  default = ["10.0.6.0/24"]
}