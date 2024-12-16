################ Configure Kubernetes Dashboard #######################################

module "kubernetes-dashboard" {
  source           = "./helm/dashboard/kubernetes-dashboard"
  count = var.install_k8s_dashboard ? 1 : 0

}

################ End Configure Kubernetes Dashboard  #######################################
