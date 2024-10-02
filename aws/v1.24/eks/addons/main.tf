resource "aws_eks_addon" "vpc-cni" {
  cluster_name                = var.eks_cluster_name
  addon_name                  = "vpc-cni"
  addon_version               = "v1.11.4-eksbuild.1"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "coredns" {
  cluster_name                = var.eks_cluster_name
  addon_name                  = "coredns"
  addon_version               = "v1.9.3-eksbuild.7"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name                = var.eks_cluster_name
  addon_name                  = "kube-proxy"
  addon_version               = "v1.24.15-eksbuild.2"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "aws_ebs_csi_driver" {
  cluster_name                = var.eks_cluster_name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = "v1.23.0-eksbuild.1"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"
}