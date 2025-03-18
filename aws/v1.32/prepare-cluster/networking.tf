## Kubernetes Network Manager Providers


################# Configure Kubernetes External DNS #######################################
#
#module "external-dns" {
#  source           = "./helm/networking/external-dns"
#  k8_config        = var.k8_config
#  aws_region = var.aws_region
#  cluster_name    = var.eks_cluster_name
#}
#
################# End Configure Kubernetes External DNS  #######################################









################ Configure Kubernetes Ingress Controller #######################################

module "ingress-controller" {
  source = "./helm/networking/ingress-controller"
  count  = var.install_ingress_controller ? 1 : 0
  additional_set = [
    {
      name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
      value = "nlb"
      type  = "string"
    },
    {
      name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-cross-zone-load-balancing-enabled"
      value = "true"
      type  = "string"
    }
  ]
}

################ End Configure Kubernetes Ingress Controller  #######################################