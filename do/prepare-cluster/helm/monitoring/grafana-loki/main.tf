resource "random_string" "grafana_loki_password" {
  length           = 16
  special          = true
  override_special = "_@"
}

resource "random_string" "grafana_loki_username" {
  length = 5
  special = false
}

resource "kubernetes_secret" "grafana_loki_auth" {
  depends_on = [random_string.grafana_loki_password, random_string.grafana_loki_username]

  type = "Opaque"
  metadata {
    name      = "grafana-loki-auth"
    namespace = "monitoring"
  }

  data = {
    "auth" : "${random_string.grafana_loki_username.result}:${bcrypt(random_string.grafana_loki_password.result)}"
  }
}

resource "helm_release" "grafana-loki" {

  name       = var.helm_release_name
  repository = var.helm_repo_url
  chart      = "grafana-loki"
  version    = var.helm_chart_version
  namespace  = "monitoring"

  values = [
    templatefile("${path.module}/templates/values.yaml", {
      bucket_name = "${var.cluster_name}-grafana-loki"
      s3   = "s3://${var.aws_access_key_s3}:${var.aws_secret_key_s3}@${var.aws_region_S3}",
      host = "grafana-loki-${var.cluster_name}.${var.dns_zone}"
    })
  ]
}
