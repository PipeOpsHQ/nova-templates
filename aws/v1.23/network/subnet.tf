# Create Subnets
module "subnets" {
  source           = "./subnets"
  eks_cluster_name = var.eks_cluster_name
  vpc_id           = module.vpc.vpc_id
  vpc_cidr_block   = module.vpc.vpc_cidr_block
  AWS_PROFILE = var.AWS_PROFILE
  workspace_name = var.pipeops_aws_account
}
