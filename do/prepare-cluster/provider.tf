terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.30.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.13.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token

}

provider "aws" {
  shared_credentials_files = var.aws_config_path
  profile                  = var.aws_profile
  region                   = var.aws_region
}

provider "kubernetes" {

  host  = data.digitalocean_kubernetes_cluster.pipeops-cluster-details.endpoint
  token = data.digitalocean_kubernetes_cluster.pipeops-cluster-details.kube_config[0].token
  cluster_ca_certificate = base64decode(
    data.digitalocean_kubernetes_cluster.pipeops-cluster-details.kube_config[0].cluster_ca_certificate
  )

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "doctl"
    args = ["kubernetes", "cluster", "kubeconfig", "exec-credential",
    "--version=v1beta1", data.digitalocean_kubernetes_cluster.pipeops-cluster-details.id]
  }
  #config_path    = "/home/toluwalope/Work/PipeOps/pks-lon1-kubeconfig (1).yaml"
}

provider "kubernetes-alpha" {
  host  = data.digitalocean_kubernetes_cluster.pipeops-cluster-details.endpoint
  token = data.digitalocean_kubernetes_cluster.pipeops-cluster-details.kube_config[0].token
  cluster_ca_certificate = base64decode(
    data.digitalocean_kubernetes_cluster.pipeops-cluster-details.kube_config[0].cluster_ca_certificate
  )
}

provider "helm" {
  kubernetes {
    host  = data.digitalocean_kubernetes_cluster.pipeops-cluster-details.endpoint
    token = data.digitalocean_kubernetes_cluster.pipeops-cluster-details.kube_config[0].token
    cluster_ca_certificate = base64decode(
      data.digitalocean_kubernetes_cluster.pipeops-cluster-details.kube_config[0].cluster_ca_certificate
    )
  }
}

provider "kubectl" {
  host  = data.digitalocean_kubernetes_cluster.pipeops-cluster-details.endpoint
  token = data.digitalocean_kubernetes_cluster.pipeops-cluster-details.kube_config[0].token
  cluster_ca_certificate = base64decode(
    data.digitalocean_kubernetes_cluster.pipeops-cluster-details.kube_config[0].cluster_ca_certificate
  )
}