resource "digitalocean_kubernetes_cluster" "pks_cluster" {
  name    = var.cluster_name
  region  = var.region
  version = var.k8s_version
  ha      = true
  node_pool {
    name       = "${var.cluster_name}-pool"
    size       = var.node_size
    node_count = var.node_count
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 6
  }
}

resource "digitalocean_kubernetes_node_pool" "bar" {
  cluster_id = digitalocean_kubernetes_cluster.pks_cluster.id

  name       = "helper-pool"
  size       = "s-2vcpu-2gb"
  node_count = 3
  tags       = ["backup-helper"]

  labels = {
    service  = "backup-helper"
    priority = "high"
  }
}