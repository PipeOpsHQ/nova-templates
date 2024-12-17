output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "region" {
  description = "AWS region"
  value       = var.aws_region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

# locals {
#   kube_config_aws_auth = <<KUBECONFIG
# apiVersion: v1
# clusters:
# - cluster:
#     server: ${module.eks.cluster_endpoint}
#     certificate-authority-data: ${module.eks.cluster_certificate_authority_data}
#   name: ${var.cluster_name}
# contexts:
# - context:
#     cluster: ${module.eks.cluster_name}
#     user: ${module.eks.cluster_name}
#   name: ${module.eks.cluster_name}
# current-context: ${module.eks.cluster_name}
# kind: Config
# preferences: {}
# users:
# - name: ${module.eks.cluster_name}
#   user:
#     exec:
#       apiVersion: client.authentication.k8s.io/v1
#       args:
#       - --region
#       - "${var.aws_region}"
#       - eks
#       - get-token
#       - --cluster-name
#       - "${module.eks.cluster_name}"
#       command: aws
#       interactiveMode: IfAvailable
#       provideClusterInfo: true
# KUBECONFIG
# }

# output "kube_config_aws_auth" {
#   value = local.kube_config_aws_auth
# }

output "eks_certificate_authority" {
  value = module.eks.cluster_certificate_authority_data
}

output "eks_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_identity_oidc_issuer_arn" {
  value = module.eks.oidc_provider_arn
}
