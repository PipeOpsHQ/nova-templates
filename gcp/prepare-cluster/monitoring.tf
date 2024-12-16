
################ Configure Kubernetes Monitoring (Kube-Prometheus Stack) #######################################

module "kube-prometheus-stack" {
  source           = "./helm/monitoring/kube-prometheus"
  count = var.install_kube_prometheus_stack ? 1 : 0
 
}

################ End Configure Kubernetes Monitoring (Kube-Prometheus Stack)  #######################################
