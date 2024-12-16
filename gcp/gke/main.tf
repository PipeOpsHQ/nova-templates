data "google_compute_network" "my-network" {
  name = "${var.cluster_name}-network"
}

data "google_compute_subnetworks" "my-subnetworks" {
  project = var.project_id
  region  = var.region
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version = "~> 33.0"

  # depends_on = [google_compute_instance.vm]

  name                                 = var.cluster_name
  project_id                           = var.project_id
  region                               = var.region
  zones                                = var.node_locations
  network                              = data.google_compute_network.my-network.name
  subnetwork                           = data.google_compute_subnetworks.my-subnetworks.subnetworks[0].name
  ip_range_pods                        = "pod-ip-range-a"
  ip_range_services                    = "service-ip-range-a"
  release_channel                      = "REGULAR"
  enable_private_endpoint              = false
  enable_private_nodes                 = true
  monitoring_enable_managed_prometheus = false
  enable_shielded_nodes                = true
  master_global_access_enabled         = false
  master_ipv4_cidr_block               = "172.16.0.0/28"
  master_authorized_networks           = var.master_authorized_networks
  deletion_protection                  = false
  remove_default_node_pool             = true
  disable_default_snat                 = true
  service_account                      = "create"
  enable_intranode_visibility = true
  kubernetes_version                   = var.kubernetes_version

  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  dns_cache                  = false
  
  node_pools = var.node_pools
  node_pools_tags     = var.node_pools_tags
  node_pools_labels   = var.node_pools_labels
  node_pools_metadata = var.node_pools_metadata
  node_pools_taints   = var.node_pools_taints

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  timeouts = {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "google_gke_hub_membership" "primary" {
  provider = google-beta

  project       = var.project_id
  membership_id = "${var.project_id}-${module.gke.name}"
  location      = var.region

  endpoint {
    gke_cluster {
      resource_link = "//container.googleapis.com/${module.gke.cluster_id}"
    }
  }
  authority {
    issuer = "https://container.googleapis.com/v1/${module.gke.cluster_id}"
  }
}
