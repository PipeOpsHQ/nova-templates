# specify the provider and access details
terraform {
  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0"
    }
    google = {
      source = "hashicorp/google"
    }
    google-beta = {
      source = "hashicorp/google-beta"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0.0"
    }
  }
}
data "google_client_config" "provider" {}

data "google_container_cluster" "my_cluster" {
  name     = var.cluster_name
  location = var.region
}

provider "aws" {
  shared_credentials_files = var.aws_config_path
  profile                  = var.aws_profile
  region                   = var.aws_region
}

provider "google" {
  project     = var.project_id
  billing_project = var.project_id
  user_project_override = true
  region      = var.region
}

provider "google-beta" {
  project     = var.project_id
  billing_project = var.project_id
  user_project_override = true
  region      = var.region
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.my_cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate,
  )
}

provider "helm" {
  kubernetes {
    host  = "https://${data.google_container_cluster.my_cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate,
  )
  }
}