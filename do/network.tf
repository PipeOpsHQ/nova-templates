resource "digitalocean_vpc" "pipeops-vpc" {
  name   = var.vpc_name
  region = var.region
}