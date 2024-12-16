
module "opencost" {
  source           = "./helm/opencost"
  count = var.install_opencost ? 1 : 0
  
}
