variable "project_id" {
  type    = string
  default = "pipeops-staging"
}

variable "region" {
  type    = string
  default = "europe-west10"
}

variable "cluster_name" {
  type    = string
  default = "pipeops-test"
}

variable "subnet_cidrs" {
  type = map(string)
  default = {
    a = "10.0.0.0/20"
    b = "10.0.16.0/20"
    c = "10.0.32.0/20"
  }
}


variable "secondary_ranges" {
  type = map(map(string))
  default = {
    pods = {
      a = "10.1.0.0/16"
      b = "10.2.0.0/16"
      c = "10.3.0.0/16"
    }
    services = {
      a = "10.4.0.0/20"
      b = "10.5.0.0/20"
      c = "10.6.0.0/20"
    }
    master_cidr = {
      a = "10.4.0.0/20"
      b = "10.5.0.0/20"
      c = "10.6.0.0/20"
    }
  }
}

variable "primary_net_cidrs" {
  type = map(string)
  # Add your primary network CIDRs here
  default = {
    internal-10  = "10.0.0.0/8"
    internal-192 = "192.168.0.0/16"
    internal-172 = "172.16.0.0/12"
  }
}
