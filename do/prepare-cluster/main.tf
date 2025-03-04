module "cert-manager" {
  source     = "./helm/cert-manager"
}
module "capsule" {
  source     = "./helm/capsule"
  depends_on = [data.digitalocean_kubernetes_cluster.pipeops-cluster-details]
}

module "capsule-proxy" {
  source       = "./helm/capsule-proxy"
  depends_on   = [data.digitalocean_kubernetes_cluster.pipeops-cluster-details]
  cluster_name = data.digitalocean_kubernetes_cluster.pipeops-cluster-details.name
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
  dns_zone = var.dns_zone
  cluster_name = data.digitalocean_kubernetes_cluster.pipeops-cluster-details.name
}

module "opencost" {
  source = "./helm/opencost"
  dns_zone = var.dns_zone
  cluster_name = data.digitalocean_kubernetes_cluster.pipeops-cluster-details.name
}

