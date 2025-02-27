
################ Configure Opencost #######################################

module "opencost" {
  source = "./helm/opencost"
  count  = var.install_opencost ? 1 : 0
  cluster_name = var.eks_cluster_name
  dns_zone = var.dns_zone

}

################ End Configure Opencost #######################################
