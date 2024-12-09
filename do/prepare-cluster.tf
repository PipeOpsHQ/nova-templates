module "cert-manager" {
  source     = "./prepare-cluster/helm/cert-manager"
  context    = digitalocean_kubernetes_cluster.pks_cluster.name
  depends_on = [digitalocean_kubernetes_cluster.pks_cluster]
}
/*
module "prometheus-server" {
  source       = "./prepare-cluster/helm/monitoring/prometheus"
  cluster_name = digitalocean_kubernetes_cluster.pks_cluster.name
  depends_on   = [digitalocean_kubernetes_cluster.pks_cluster]
}
*/
module "metrics-server" {
  source     = "./prepare-cluster/helm/monitoring/metrics-server"
  depends_on = [digitalocean_kubernetes_cluster.pks_cluster]
}

module "ingress-controller" {
  source         = "./prepare-cluster/helm/networking/nginx-ingress-controller"
  additional_set = []
  depends_on     = [digitalocean_kubernetes_cluster.pks_cluster]
}

module "coredns" {
  source     = "./prepare-cluster/helm/networking/coredns"
  depends_on = [digitalocean_kubernetes_cluster.pks_cluster]
}

module "capsule" {
  source     = "./prepare-cluster/helm/capsule"
  depends_on = [digitalocean_kubernetes_cluster.pks_cluster]
}

module "capsule-proxy" {
  source       = "./prepare-cluster/helm/capsule-proxy"
  depends_on   = [digitalocean_kubernetes_cluster.pks_cluster]
  cluster_name = digitalocean_kubernetes_cluster.pks_cluster.name
}


module "kube-prometheus-stack" {
  source = "./prepare-cluster/helm/monitoring/kube-prometheus"
}

module "opencost" {
  source = "./prepare-cluster/helm/opencost"
}

