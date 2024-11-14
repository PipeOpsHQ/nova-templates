## Kubernetes Monitoring Manager Providers


################ Configure Kubernetes Monitoring (Metrics Server) #######################################

module "metrics-server" {
  source          = "./helm/monitoring/metrics-server"
  count           = var.install_metrics_server ? 1 : 0
  k8_config       = var.k8_config
  cluster_package = var.cluster_package
}

################ End Configure Kubernetes Monitoring (Metrics Server)  #######################################


/*
################ Configure Kubernetes Monitoring (Prometheus Operator) #######################################

module "prometheus-server" {
  source           = "./helm/monitoring/prometheus"
  count = var.install_prometheus ? 1 : 0
  k8_config        = var.k8_config
  cluster_name     = var.eks_cluster_name
  dns_zone         = var.dns_zone
}

################ End Configure Kubernetes Monitoring (Prometheus Operator)  #######################################
*/

################ Configure Kubernetes Monitoring (Kube-Prometheus Stack) #######################################

module "kube-prometheus-stack" {
  source = "./helm/monitoring/kube-prometheus"
  count  = var.install_kube_prometheus_stack ? 1 : 0

  /*
  k8_config        = var.k8_config
  cluster_name     = var.eks_cluster_name
  dns_zone         = var.dns_zone
  */
}

################ End Configure Kubernetes Monitoring (Kube-Prometheus Stack)  #######################################