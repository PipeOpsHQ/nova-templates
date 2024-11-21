resource "kubernetes_namespace" "monitoring" {
  metadata {
    annotations = {
      name = "monitoring"
    }

    name = "monitoring"
  }
}

resource "helm_release" "kube_prometheus_stack" {
  # depends_on = [kubernetes_secret.prometheus-basic-auth]

  name = var.helm_release_name
  repository = var.helm_repo_url
  chart      = var.helm_chart_name
  version = var.helm_chart_version
  create_namespace = "true"
  namespace = "monitoring"

  values = [ 
    templatefile("${path.module}/templates/values.yaml", {
      namespace = "monitoring"
    })
   ]
}
