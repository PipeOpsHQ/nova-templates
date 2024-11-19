
################ Configure Opencost #######################################

module "opencost" {
  source = "./helm/opencost"
  count  = var.install_opencost ? 1 : 0

}

################ End Configure Opencost #######################################
