data "digitalocean_vpc" "vpc" {
  name = var.vpc_name
}

resource "digitalocean_kubernetes_cluster" "pks_cluster" {
  name    = var.cluster_name
  region  = var.region
  version = var.k8s_version
  vpc_uuid = data.digitalocean_vpc.vpc.id
  ha      = true
  node_pool {
    name       = "${var.cluster_name}-pool"
    size       = var.node_size
    node_count = var.node_count
    auto_scale = false
    min_nodes  = 1
    max_nodes  = 3
  }
}

resource "digitalocean_kubernetes_node_pool" "bar" {
  cluster_id = digitalocean_kubernetes_cluster.pks_cluster.id

  name       = "helper-pool"
  size       = "s-2vcpu-2gb"
  node_count = 2
  min_nodes = 2
  auto_scale = true
  max_nodes = 4
  tags       = ["backup-helper"]

  labels = {
    service  = "backup-helper"
    priority = "high"
  }
  taint {
    key    = "managed-by"
    value  = "helper-pool"
    effect = "NoSchedule"
  }
}

resource "digitalocean_kubernetes_node_pool" "ingress_pool" {
  cluster_id = digitalocean_kubernetes_cluster.pks_cluster.id

  name       = "ingress-pool"
  size       = "s-8vcpu-16gb-amd"
  node_count = 1
  min_nodes  = 1
  max_nodes  = 1

  labels = {
    service  = "ingress-pool"
    priority = "high"
  }
  taint {
    key    = "managed-by"
    value  = "ingress-pool"
    effect = "NoSchedule"
  }
}

resource "digitalocean_kubernetes_node_pool" "default_pool" {
  cluster_id = digitalocean_kubernetes_cluster.pks_cluster.id

  name       = "default-pool"
  size       = "s-2vcpu-4gb-120gb-intel"
  node_count = 1
  min_nodes  = 1
  auto_scale = true
  max_nodes  = 2

  labels = {
    service  = "default-pool"
    priority = "high"
  }
  taint {
    key    = "managed-by"
    value  = "default-pool"
    effect = "NoSchedule"
  }

}