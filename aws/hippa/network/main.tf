module "network" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "${var.pipeops_workspace_account}-vpc"

  cidr = var.vpc_cidr

  azs = slice(
    data.aws_availability_zones.available.names,
    0,
    min(length(data.aws_availability_zones.available.names), 3)
  )

  private_subnets = var.private_subnets_cidrs
  public_subnets  = var.public_subnets_cidrs

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true


  public_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                        = 1
    "subnet"                                        = "public"
    "map_public_ip_on_launch"                       = true
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"               = 1
    "subnet"                                        = "private"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
