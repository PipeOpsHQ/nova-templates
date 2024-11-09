resource "helm_release" "opencost" {

  name = var.helm_release_name
  repository = var.helm_repo_url
  chart      = var.helm_chart_name
  version = var.helm_chart_version
  namespace = var.k8s_namespace

}

