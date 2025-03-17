## Kubernetes Certificate Manager


################ Configure Kubernetes Cert Manager #######################################

module "cert-manager" {
  source  = "./helm/cert-manager"
  count   = var.install_cert_manager ? 1 : 0
  context = var.eks_cluster_name
}

################ End Configure Kubernetes Cert Manager  #######################################
