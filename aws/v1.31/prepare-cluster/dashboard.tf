################ Configure Kubernetes Dashboard #######################################

module "kubernetes-dashboard" {
  source       = "./helm/dashboard/kubernetes-dashboard"
  count        = var.install_k8s_dashboard ? 1 : 0
  cluster_name = var.eks_cluster_name
  dns_zone     = var.dns_zone
}

################ End Configure Kubernetes Dashboard  #######################################
