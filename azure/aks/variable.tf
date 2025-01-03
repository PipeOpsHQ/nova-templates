variable "subscription_id" {
  type = string

}

variable "resource_group_name" {
  type = string

}

variable "resource_group_location" {
  type = string

}

variable "cluster_name" {
  type = string
}

variable "vnet_name" {
  type = string
  default = "pipeops-network"
}

variable "pipeops_subnet_name" {
  description = "Name of public subnet"
  type = string
  default = "pipeops-subnet-3"
}

variable "client_id" {
  description = "The Client ID (appId) for the Service Principal used for the AKS deployment"
  type = string

}

variable "client_secret" {
  description = "The Client Secret (password) for the Service Principal used for the AKS deployment"
  type = string

}

variable "kubernetes_version" {
  type = string
  description = "value"
  default = "1.30"
}

variable "node_pool_name" {
  description = " The name of the Node Pool created within the Kubernetes Cluster."
  type = string

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
