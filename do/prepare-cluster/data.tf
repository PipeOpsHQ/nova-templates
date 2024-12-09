data "digitalocean_kubernetes_cluster" "pipeops-cluster-details" {
  name = var.cluster_name
}