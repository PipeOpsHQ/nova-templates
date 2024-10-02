resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster_name
  role_arn = var.iam_cluster_arn
  version = var.eks_version

  vpc_config {
    security_group_ids = [var.security_group_cluster]
    subnet_ids         = var.subnets
    endpoint_public_access = true
    endpoint_private_access = true
    public_access_cidrs  = ["0.0.0.0/0"]
  }

#  depends_on = [aws_cloudwatch_log_group.eks_cluster]

  enabled_cluster_log_types = ["api","audit","authenticator","controllerManager","scheduler"]

  tags = {
    Owner = var.workspace
  }
}

#resource "aws_cloudwatch_log_group" "eks_cluster" {
#  # The log group name format is /aws/eks/<cluster-name>/cluster
#  # Reference: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
#  name              = "/aws/eks/${var.eks_cluster_name}/cluster"
#  retention_in_days = 30
#}