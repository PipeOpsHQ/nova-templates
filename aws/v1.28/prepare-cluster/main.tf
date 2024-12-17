## Kubernetes Cluster AutoScaler


################ Configure Cluster Auto Scaler  #######################################

module "autoscaler" {
  source       = "./helm/autoscaler"
  cluster_name = var.eks_cluster_name
  aws_region   = var.aws_region
}

################ End Configure Cluster Auto Scaler  #######################################
