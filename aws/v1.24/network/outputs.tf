output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "gw_id" {
  value = module.vpc.gw_id
}

output "main_route_table_id" {
  value = module.vpc.main_route_table_id
}

output "vpc_dhcp_id" {
  value = module.vpc.vpc_dhcp_id
}

output "subnets" {
  value = [module.subnets.subnets]
}

output "route_id" {
  value = module.route.route_id
}

