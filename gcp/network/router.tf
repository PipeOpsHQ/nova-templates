# Cloud NAT Module
module "cloud-nat" {
  source        = "terraform-google-modules/cloud-nat/google"
  version       = "~> 5.0"
  project_id    = var.project_id
  region        = var.region
  name          = "${var.cluster_name}-nat"
  router        = "${var.cluster_name}-router"
  network       = module.net.network_self_link
  create_router = true
}