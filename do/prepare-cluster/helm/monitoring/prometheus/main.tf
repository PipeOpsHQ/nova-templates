resource "random_string" "password" {
  length           = 32
  special          = true
  override_special = "_@"
}

resource "kubernetes_secret" "prometheus-basic-auth" {
  depends_on = [random_string.password]

  type = "Opaque"
  metadata {
    name      = "${var.cluster_name}-basic-auth"
    namespace = var.k8s_namespace
  }

  data = {
    "auth" : "${var.cluster_name}:${bcrypt("ALp9qwkffbPuuuugh8K6Q4fpd69vpZ9z")}"
  }
}

resource "helm_release" "prometheus_monitoring" {
  depends_on = [kubernetes_secret.prometheus-basic-auth]

  name             = var.helm_release_name
  repository       = var.helm_repo_url
  chart            = var.helm_chart_name
  version          = var.helm_chart_version
  namespace        = var.k8s_namespace
  create_namespace = var.helm_create_namespace


  values = [
    templatefile("${path.module}/templates/values.yaml", {
      host       = "${var.cluster_name}.antqube.app",
      secretName = kubernetes_secret.prometheus-basic-auth.metadata[0].name
      # Configure persistence for Prometheus data directory
      prometheus = {
        server = {
          persistentVolume = {
            enabled      = true
            storageClass = "standard"
            accessModes  = ["ReadWriteOnce"]
            size         = "10Gi"
          }
        }
      }
    })
  ]
}
