################ Configure Kubernetes Dashboard #######################################

module "kubernetes-dashboard" {
  source           = "./helm/dashboard/kubernetes-dashboard"
  cluster_name     = var.eks_cluster_name
  dns_zone         = var.dns_zone
}

################ End Configure Kubernetes Dashboard  #######################################
