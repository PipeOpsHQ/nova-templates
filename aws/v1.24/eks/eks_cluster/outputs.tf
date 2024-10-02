locals {
  config_map_aws_auth = <<CONFIGMAPAWSAUTH
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${var.iam_node_arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH

  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.eks_cluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.eks_cluster.certificate_authority.0.data}
  name: ${var.eks_cluster_name}
contexts:
- context:
    cluster: ${var.eks_cluster_name}
    user: ${var.eks_cluster_name}
  name: ${var.eks_cluster_name}
current-context: ${var.eks_cluster_name}
kind: Config
preferences: {}
users:
- name: ${var.eks_cluster_name}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1
      args:
      - --region
      - "${var.aws_region}"
      - eks
      - get-token
      - --cluster-name
      - "${var.eks_cluster_name}"
      command: aws
      env:
      - name: AWS_PROFILE
        value: "${var.aws_profile}"
      interactiveMode: IfAvailable
      provideClusterInfo: true
KUBECONFIG
}

output "config_map_aws_auth" {
  value = local.config_map_aws_auth
}

output "kubeconfig" {
  value = local.kubeconfig
}

output "eks_certificate_authority" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "eks_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_name" {
  value = var.eks_cluster_name
}

output "cluster_identity_oidc_issuer_arn" {
  value = var.iam_cluster_arn
}
