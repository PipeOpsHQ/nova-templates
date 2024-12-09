data "digitalocean_kubernetes_cluster" "pipeops-cluster-details" {
  name = digitalocean_kubernetes_cluster.pks_cluster.name
}