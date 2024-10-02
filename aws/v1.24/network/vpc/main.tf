# Create a VPC to launch build instances into
resource "aws_vpc" "vpc_id" {
  cidr_block           = var.cidr_block[terraform.workspace]
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = "${var.workspace_name}-vpc",
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared",
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "gw_id" {
  vpc_id = aws_vpc.vpc_id.id

  tags = {
    Name = "${var.workspace_name}-ig"
  }
}

# Create dhcp option setup
resource "aws_vpc_dhcp_options" "vpc_dhcp_id" {
  domain_name         = "${var.aws_region}.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    Name = "${var.workspace_name}-vpc-dhcp"
  }
}
