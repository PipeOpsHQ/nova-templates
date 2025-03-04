module "cert-manager" {
  source     = "./helm/cert-manager"
}
module "capsule" {
  source     = "./helm/capsule"
  depends_on = [digitalocean_kubernetes_cluster.pks_cluster]
}

module "capsule-proxy" {
  source       = "./helm/capsule-proxy"
  depends_on   = [digitalocean_kubernetes_cluster.pks_cluster]
  cluster_name = digitalocean_kubernetes_cluster.pks_cluster.name
}

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
  dns_zone = 
}

module "opencost" {
  source = "./helm/opencost"
}

