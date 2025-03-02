## Kubernetes Monitoring Manager Providers


################ Configure Kubernetes Monitoring (Metrics Server) #######################################

module "metrics-server" {
  source          = "./helm/monitoring/metrics-server"
  count           = var.install_metrics_server ? 1 : 0
  cluster_package = var.cluster_package
}

################ End Configure Kubernetes Monitoring (Metrics Server)  #######################################

################ Configure Kubernetes Monitoring (Kube-Prometheus Stack) #######################################

module "kube-prometheus-stack" {
  source = "./helm/monitoring/kube-prometheus"
  count  = var.install_kube_prometheus_stack ? 1 : 0
  cluster_name     = var.eks_cluster_name
  dns_zone         = var.dns_zone
  depends_on = [ module.ingress-controller ]
}

################ End Configure Kubernetes Monitoring (Kube-Prometheus Stack)  #######################################