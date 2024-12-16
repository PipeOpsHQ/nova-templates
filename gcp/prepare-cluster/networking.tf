
################ Configure Kubernetes Ingress Controller #######################################

module "ingress-controller" {
  source           = "./helm/networking/ingress-controller"
  count = var.install_ingress_controller ? 1 : 0
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