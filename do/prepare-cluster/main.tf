module "cert-manager" {
  source     = "./helm/cert-manager"
}
/*
module "prometheus-server" {
  source       = "./prepare-cluster/helm/monitoring/prometheus"
  cluster_name = digitalocean_kubernetes_cluster.pks_cluster.name
  depends_on   = [digitalocean_kubernetes_cluster.pks_cluster]
}
*/
module "metrics-server" {
  source     = "./helm/monitoring/metrics-server"
}

module "ingress-controller" {
  source         = "./helm/networking/nginx-ingress-controller"
  additional_set = []
}

module "coredns" {
  source     = "./helm/networking/coredns"
}


module "kube-prometheus-stack" {
  source = "./helm/monitoring/kube-prometheus"
}

module "opencost" {
  source = "./helm/opencost"
}

