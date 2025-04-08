# Create cert-manager namespace
resource "kubernetes_namespace" "capsule_proxy" {
  metadata {
    name = var.k8s_namespace
  }
}


resource "helm_release" "capsule_proxy" {
  name       = var.helm_release_name
  repository = var.helm_repo_url
  chart      = var.helm_chart_name
  namespace  = var.k8s_namespace
  version    = var.helm_chart_version

  values = [
    templatefile("${path.module}/templates/values.yaml", {
      value="default-pool"
      cluster_name = "${var.cluster_name}"
    })
    ]

  depends_on = [
    kubernetes_namespace.capsule_proxy,
  ]
}