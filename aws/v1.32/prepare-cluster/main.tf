## Kubernetes Cluster AutoScaler


################ Configure Cluster Auto Scaler  #######################################

module "autoscaler" {
  source       = "./helm/autoscaler"
  count        = var.install_autoscaler ? 1 : 0
  cluster_name = var.eks_cluster_name
  aws_region   = var.aws_region
}

################ End Configure Cluster Auto Scaler  #######################################
