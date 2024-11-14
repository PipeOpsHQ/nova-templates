
################ Configure Rabbitmq #######################################

module "rabbitmq" {
  source           = "./helm/rabbitmq"
  count = var.install_rabbitmq ? 1 : 0
  /*
  k8_config        = var.k8_config
  cluster_name     = var.eks_cluster_name
  dns_zone         = var.dns_zone
  */
}

################ End Configure Rabbitmq #######################################
