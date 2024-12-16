## Kubernetes Certificate Manager

################ Configure Kubernetes Cert Manager #######################################

module "cert-manager" {
  source           = "./helm/cert-manager"
  count = var.install_cert_manager ? 1 : 0
}

################ End Configure Kubernetes Cert Manager  #######################################
