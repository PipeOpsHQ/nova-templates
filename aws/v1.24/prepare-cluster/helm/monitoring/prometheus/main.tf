resource "random_string" "password" {
  length           = 32
  special          = true
  override_special = "_@"
}

resource "kubernetes_secret" "prometheus-basic-auth" {
  type = "Opaque"
  metadata {
    name      = "${var.cluster_name}-basic-auth"
    namespace = var.k8s_namespace
  }

  data = {
    "auth" : "${var.cluster_name}:${bcrypt(random_string.password.result)}"
  }
}

resource "helm_release" "prometheus_monitoring" {
  depends_on = [kubernetes_secret.prometheus-basic-auth]

  name = var.helm_release_name
  repository = var.helm_repo_url
  chart      = var.helm_chart_name
  version = var.helm_chart_version
  namespace = var.k8s_namespace
  create_namespace = var.helm_create_namespace
  force_update = true


  values = [
    templatefile("${path.module}/templates/values.yaml", {
      host = "prom.${var.cluster_name}.${var.dns_zone}",
      secretName = kubernetes_secret.prometheus-basic-auth.metadata[0].name
      # Configure persistence for Prometheus data directory
      prometheus = {
        server = {
          persistentVolume = {
            enabled = true
            storageClass = "standard"
            accessModes = ["ReadWriteOnce"]
            size = "10Gi"
          }
        }
      }
    })
  ]
}
