output "nat_gateway" {
  description = "Network Nat Gateway IP"
  sensitive   = false
  value       = module.network.nat_public_ips
}

output "azs" {
  description = "Network Nat Gateway IP"
  sensitive   = false
  value       = module.network.azs
}

output "vpc_cidr_block" {
  description = "Network Nat Gateway IP"
  sensitive   = false
  value       = module.network.vpc_cidr_block
}

output "network_name" {
  description = "Network Nat Gateway IP"
  sensitive   = false
  value       = module.network.name
}

output "private_subnets" {
  description = "Network Nat Gateway IP"
  sensitive   = false
  value       = module.network.private_subnets
}

output "public_subnets" {
  description = "Network Nat Gateway IP"
  sensitive   = false
  value       = module.network.public_subnets
}
