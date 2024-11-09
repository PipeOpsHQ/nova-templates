terraform {
  required_version = ">= 1.0.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.18.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "= 2.5.1"
    }
  }
}