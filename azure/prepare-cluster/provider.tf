
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.10.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.18.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "= 2.13.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    resource_group {
     prevent_deletion_if_contains_resources = false
    }
  }

  subscription_id = var.subscription_id
}


data "azurerm_kubernetes_cluster" "pipeops-cluster" {
  name                = var.cluster_name
  resource_group_name = var.resource_group_name
}
provider "aws" {
  shared_credentials_files = var.aws_config_path
  profile                  = var.aws_profile
  region                   = var.aws_region
}

provider "kubernetes" {
  host                   = "${data.azurerm_kubernetes_cluster.pipeops-cluster.kube_config.0.host}"
  client_certificate     = "${base64decode(data.azurerm_kubernetes_cluster.pipeops-cluster.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(data.azurerm_kubernetes_cluster.pipeops-cluster.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(data.azurerm_kubernetes_cluster.pipeops-cluster.kube_config.0.cluster_ca_certificate)}"
}

provider "helm" {
  kubernetes {
    host                   = "${data.azurerm_kubernetes_cluster.pipeops-cluster.kube_config.0.host}"
    client_certificate     = "${base64decode(data.azurerm_kubernetes_cluster.pipeops-cluster.kube_config.0.client_certificate)}"
    client_key             = "${base64decode(data.azurerm_kubernetes_cluster.pipeops-cluster.kube_config.0.client_key)}"
    cluster_ca_certificate = "${base64decode(data.azurerm_kubernetes_cluster.pipeops-cluster.kube_config.0.cluster_ca_certificate)}"
  }
}

provider "kubectl" {
  host                   = "${data.azurerm_kubernetes_cluster.pipeops-cluster.kube_config.0.host}"
  client_certificate     = "${base64decode(data.azurerm_kubernetes_cluster.pipeops-cluster.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(data.azurerm_kubernetes_cluster.pipeops-cluster.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(data.azurerm_kubernetes_cluster.pipeops-cluster.kube_config.0.cluster_ca_certificate)}"
}