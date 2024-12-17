resource "random_string" "grafana-loki-password" {
  length           = 16
  special          = true
  override_special = "_@"
}
/*
resource "random_string" "grafana-loki-username" {
  length = 5
  special = false
}

*/
resource "kubernetes_secret" "grafana-loki-auth" {
  depends_on = [random_string.grafana-loki-password, random_string.grafana-loki-username]

  type = "Opaque"
  metadata {
    name      = "grafana-loki-auth"
    namespace = "monitoring"
  }

  data = {
    "htpasswd": "${bcrypt(random_string.grafana_loki_password.result)}"
    "password": "${bcrypt(random_string.grafana_loki_password.result)}"
  }
}


resource "helm_release" "grafana-loki" {

  name = var.helm_release_name
  repository = var.helm_repo_url
  chart      = "grafana-loki"
  version = var.helm_chart_version
  namespace = "monitoring"
  set {
    name = "global.defaultStorageClass"
    value = "gp2"
  }
  set {
    name = "serviceAccount.create"
    value = true
  }

  set {
    name = "serviceAccount.name"
    value = "loki-sa"
  }

  set {
    name = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "arn:aws:iam::022499013216:role/pipeops-loki-irsa"
  } 
  values = [
    templatefile("${path.module}/templates/values.yaml", {
      s3 = "s3://${var.region}/${var.bucket_name}",
      host = "grafana-loki-${var.cluster_name}.${var.dns_zone}"
    })
  ]
}
