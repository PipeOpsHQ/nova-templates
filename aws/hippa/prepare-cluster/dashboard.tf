################ Configure Kubernetes Dashboard #######################################

module "kubernetes-dashboard" {
  source           = "./helm/dashboard/kubernetes-dashboard"
  k8_config        = var.k8_config
  cluster_name     = var.eks_cluster_name
}

################ End Configure Kubernetes Dashboard  #######################################
