resource "helm_release" "cluster_autoscaler" {
  name = var.helm_release_name
  repository = var.helm_repo_url
  chart      = var.helm_chart_name
  version    = var.helm_chart_version

  set {
    name  = "autoDiscovery.enabled"
    value = "true"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "cloudProvider"
    value = var.aws_provider
  }

  set {
    name  = "awsRegion"
    value = var.aws_region
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

#  set {
#    name  = "rbac.serviceAccount.annotations"
#    value = var.service_account_role_name
#  }
}
