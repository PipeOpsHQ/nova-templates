## Kubernetes Certificate Manager


################ Configure Kubernetes Cert Manager #######################################

module "sealed-secret" {
  source           = "./helm/secret-manager/sealed-secret"
  k8_config        = var.k8_config
  context        = var.eks_cluster_name
}

################ End Configure Kubernetes Cert Manager  #######################################
