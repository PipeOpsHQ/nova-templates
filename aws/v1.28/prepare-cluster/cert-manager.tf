## Kubernetes Certificate Manager


################ Configure Kubernetes Cert Manager #######################################

module "cert-manager" {
  source           = "./helm/cert-manager"
  context        = var.eks_cluster_name
}

################ End Configure Kubernetes Cert Manager  #######################################
