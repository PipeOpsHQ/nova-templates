variable "project_id" {
  type = string
  default = "pipeops-staging"
}

variable "region" {
  type = string
  default = "europe-west10"
}

variable "cluster_name" {
  type = string
  default = "pipeops-test"
}

variable "node_locations" {
  type = list(string)
  default = [ "europe-west10-a", "europe-west10-b", "europe-west10-c" ]
}

variable "master_authorized_networks" {
  type        = list(object({ cidr_block = string, display_name = string }))
  description = "List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists)."
  default = [ {
    cidr_block = "0.0.0.0/0"
    display_name = "All networks"
  }]
}

variable "kubernetes_version" {
  type        = string
  description = "The Kubernetes version of the masters. If set to 'latest' it will pull latest available version in the selected region."
  default     = "1.30"
}

variable "node_pools" {
  type = list(object({
    name                 = string
    machine_type         = string
    node_locations       = string  # Changed back to string
    min_count            = number
    max_count            = number
    local_ssd_count      = number
    disk_size_gb         = number
    disk_type            = string
    image_type           = string
    auto_repair          = bool
    auto_upgrade         = bool
    preemptible          = bool
    initial_node_count   = number
    autoscaling_profile  = string
    autoscaling          = bool
  }))
  description = "List of node pool configurations"

  default = [ {
    name = "pipeops-test-nodepool"
    machine_type = "e2-small"
    node_locations = "europe-west10-a,europe-west10-b,europe-west10-c"
    min_count = 2
    max_count = 6
    local_ssd_count = 0
    disk_size_gb = 20
    disk_type = "pd-standard"
    image_type = "COS_CONTAINERD"
    auto_repair = true
    auto_upgrade = true
    preemptible = false
    initial_node_count = 2
    autoscaling_profile = "BALANCED"
    autoscaling = true
  } ]
}

variable "node_pools_tags" {
  type = map(list(string))
  default = {
    "pipeops-test-nodepool" = [ "pipeops-test" ]
    "all"=[]
  }
}
variable "node_pools_labels" {
  type = map(map(string))
  default = {
    "pipeops-test-nodepool" = {
      "pipeops-test" = "true"
    },
    all = {}
  }
}

variable "node_pools_metadata" {
  type = map(map(string))
  default = {
    pipeops-test-nodepool = {
      node-pool-metadata-custom-value = "pipeops-test"
    },
    all = {}
  }
}
variable "node_pools_taints" {
  type = map(list(object({
    key    = string
    value  = string
    effect = string
  })))
  default = {
    "all": [],
    "pipeops-test-nodepool": []
  }    
}
