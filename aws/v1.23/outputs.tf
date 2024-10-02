output "security_group_cluster" {
  value = module.eks_sec_group.security_group_cluster
}

output "security_group_node" {
  value = module.eks_sec_group.security_group_node
}

output "config_map_aws_auth" {
  value = module.eks_cluster.config_map_aws_auth
}

output "kubeconfig" {
  value = module.eks_cluster.kubeconfig
}

output "eks_certificate_authority" {
  value = module.eks_cluster.eks_certificate_authority
}

output "eks_endpoint" {
  value = module.eks_cluster.eks_endpoint
}

output "eks_cluster_name" {
  value = module.eks_cluster.eks_cluster_name
}