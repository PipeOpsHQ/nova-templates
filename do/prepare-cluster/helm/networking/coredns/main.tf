resource "helm_release" "coredns" {
  name       = var.helm_release_name
  repository = var.helm_repo_url
  chart      = var.helm_chart_name
  namespace  = var.k8s_namespace
  version    = var.helm_chart_version

#   values = [ templatefile("${path.module}/templates/values.yaml")]

  values = ["${file("${path.module}/templates/values.yaml")}"]
}
