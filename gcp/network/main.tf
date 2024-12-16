
resource "random_id" "rand" {
  byte_length = 4
}

resource "google_service_account" "gke-sa" {
  account_id = "gke-sa-${random_id.rand.hex}"
  project    = var.project_id
}

# Network Module
module "net" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 9.0"
  project_id   = var.project_id
  network_name = "${var.cluster_name}-network"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "${var.cluster_name}-subnet-a"
      subnet_ip     = var.subnet_cidrs["a"]
      subnet_region = var.region
    },
    {
      subnet_name           = "${var.cluster_name}-subnet-b"
      subnet_ip             = var.subnet_cidrs["b"]
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name   = "${var.cluster_name}-subnet-c"
      subnet_ip     = var.subnet_cidrs["c"]
      subnet_region = var.region
    }
  ]

  secondary_ranges = {
    "${var.cluster_name}-subnet-a" = [
      {
        range_name    = "pod-ip-range-a"
        ip_cidr_range = var.secondary_ranges["pods"]["a"]
      },
      {
        range_name    = "service-ip-range-a"
        ip_cidr_range = var.secondary_ranges["services"]["a"]
      }
    ],
    "${var.cluster_name}-subnet-b" = [
      {
        range_name    = "pod-ip-range-b"
        ip_cidr_range = var.secondary_ranges["pods"]["b"]
      },
      {
        range_name    = "service-ip-range-b"
        ip_cidr_range = var.secondary_ranges["services"]["b"]
      }
    ],
    "${var.cluster_name}-subnet-c" = [
      {
        range_name    = "pod-ip-range-c"
        ip_cidr_range = var.secondary_ranges["pods"]["c"]
      },
      {
        range_name    = "service-ip-range-c"
        ip_cidr_range = var.secondary_ranges["services"]["c"]
      }
    ]
  }

  routes = concat(
    [for k, v in var.primary_net_cidrs : { # ask to confirm vars
      name              = "${var.cluster_name}-egress-gke-${k}"
      description       = "Egress through Cloud NAT for range ${v}"
      destination_range = v
      tags              = "gke-${var.cluster_name}"
      next_hop_internet = true
    }],
    [{
      name              = "${var.cluster_name}-default-igw"
      description       = "Default route through Cloud NAT"
      destination_range = "0.0.0.0/0"
      tags              = "gke-${var.cluster_name}"
      next_hop_internet = true
    }]
  )
}

# Firewall Rules
resource "google_compute_firewall" "rules" {
  for_each = {
    iap = {
      name        = "${var.cluster_name}-iap"
      description = "Allow incoming traffic from IAP"
      direction   = "INGRESS"
      allow       = [{ protocol = "tcp", ports = ["22"] }]
      ranges      = ["35.235.240.0/20"]
    }
    internal = {
      name        = "${var.cluster_name}-internal"
      description = "Allow internal traffic"
      direction   = "INGRESS"
      allow       = [{ protocol = "tcp" }, { protocol = "udp" }, { protocol = "icmp" }]
      ranges = concat(
        values(var.subnet_cidrs),
        values(var.secondary_ranges["pods"])
      )
    }
  }

  name        = each.value.name
  description = each.value.description
  direction   = each.value.direction
  network     = module.net.network_name

  dynamic "allow" {
    for_each = each.value.allow
    content {
      protocol = allow.value.protocol
      ports    = lookup(allow.value, "ports", null)
    }
  }

  source_ranges           = lookup(each.value, "ranges", null)
  target_service_accounts = each.key == "psc" ? [google_service_account.gke-sa.email] : null

  depends_on = [module.net]
}