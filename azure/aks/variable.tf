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

variable "cluster_name" {
  default = "pipeops-tests"
}

variable "vnet_name" {
  type = string
  default = "pipeops-network"
}

variable "pipeops_subnet_3_name" {
  description = "Name of public subnet"
  type = string
  default = "pipeops-subnet-3"
}

variable "client_id" {
  description = "value"
  type = string
  default = "ae2f2166-765e-4ca4-a765-ecd9f5d69c7a"
}

variable "client_secret" {
  description = "value"
  type = string
  default = "nzJ8Q~NOtI9UvMn3oWn61.vIQKCNOt8DbKcx4dxo"
}

variable "kubernetes_version" {
  type = string
  description = "value"
  default = "1.30"
}

variable "node_pool_name" {
  type = string
  default = "test"
} 

variable "node_count" {
  type = number
  default = 1
}

variable "vm_size" {
  type = string
  default = "Standard_A2_v2"
}

variable "max_count" {
  type = number
  default = 2
}
