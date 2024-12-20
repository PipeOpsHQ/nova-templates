## Kubernetes Cluster AutoScaler


################ Configure Cluster Auto Scaler  #######################################

module "autoscaler" {
  source       = "./helm/autoscaler"
  count        = var.install_autoscaler ? 1 : 0

}

################ End Configure Cluster Auto Scaler  #######################################
