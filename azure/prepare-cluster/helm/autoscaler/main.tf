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
    value = var.azure_provider
  }


  set {
    name  = "rbac.create"
    value = "true"
  }

  values = [
    templatefile("${path.module}/templates/values.yaml", {
      cluster-name = "${var.cluster_name}"
      client_id = "${var.client_id}"
      client_secret = "${var.client_secret}"
      resource_group_name = "${var.resource_group_name}"
      subscription_id = "${var.subscription_id}"
      tenant_id = "${var.tenant_id}"
    })
  ]
}
