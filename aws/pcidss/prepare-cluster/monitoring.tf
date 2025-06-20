## Kubernetes Monitoring Manager Providers


################ Configure Kubernetes Monitoring (Metrics Server) #######################################

module "metrics-server" {
  source           = "./helm/monitoring/metrics-server"
  k8_config        = var.k8_config
  cluster_package  = var.cluster_package
}

################ End Configure Kubernetes Monitoring (Metrics Server)  #######################################



################ Configure Kubernetes Monitoring (Prometheus Operator) #######################################

module "prometheus-server" {
  source           = "./helm/monitoring/prometheus"
  k8_config        = var.k8_config
  cluster_name     = var.eks_cluster_name
}

################ End Configure Kubernetes Monitoring (Prometheus Operator)  #######################################
