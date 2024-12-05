resource "random_string" "kube-prom-password" {
  length           = 16
  special          = true
  override_special = "_@"
}

resource "kubernetes_secret" "kube-prom-auth" {
  depends_on = [random_string.kube-prom-password]

  type = "Opaque"
  metadata {
    name      = "kube-prom-auth"
    namespace = monitoring
  }

  data = {
    "auth" : "admin:${bcrypt(random_string.kube-prom-password.result)}"
  }
}


resource "random_string" "kube-grafana-password" {
  length           = 16
  special          = true
  override_special = "_@"
}


resource "kubernetes_secret" "kube-grafana-basic-auth" {
  depends_on = [random_string.kube-grafana-password]

  type = "Opaque"
  metadata {
    name      = "kube-grafana-basic-auth"
    namespace = "monitoring"
  }

  data = {
    "auth" : "admin:${bcrypt(random_string.kube-grafana-password.result)}"
  }
}

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
      namespace = "monitoring",
      host = "kube-prom.pipeops.dev"
    })
   ]
}
