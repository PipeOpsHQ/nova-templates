# Configure Routes
module "route" {
  source              = "./route"
  main_route_table_id = module.vpc.main_route_table_id
  gw_id               = module.vpc.gw_id

  subnets = [
    module.subnets.subnets,
  ]
  AWS_PROFILE = var.AWS_PROFILE
  workspace_name = var.pipeops_aws_account
}

