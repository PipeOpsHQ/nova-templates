
################ Configure Opencost #######################################

module "opencost" {
  source = "./helm/opencost"
  count  = var.install_opencost ? 1 : 0
  cluster_name = var.eks_cluster_name
  dns_zone = var.dns_zone
  depends_on = [ module.ingress-controller ]
}

################ End Configure Opencost #######################################
