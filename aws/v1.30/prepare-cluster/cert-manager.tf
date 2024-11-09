## Kubernetes Certificate Manager


################ Configure Kubernetes Cert Manager #######################################

module "cert-manager" {
  source           = "./helm/cert-manager"
  k8_config        = var.k8_config
  context        = var.eks_cluster_name
}

################ End Configure Kubernetes Cert Manager  #######################################
