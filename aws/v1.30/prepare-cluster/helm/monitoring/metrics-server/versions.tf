terraform {
  required_version = ">= 1.0.10"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.18.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "= 2.5.1"
    }
    aws        = ">= 3.13, < 4.0"
  }
}