resource "random_string" "kube-prom-username" {
  length = 5
  special = false
}

resource "random_string" "kube-prom-password" {
  length           = 16
  special          = true
  override_special = "_@"
}

resource "kubernetes_secret" "kube-prom-auth" {
  depends_on = [random_string.kube-prom-password, random_string.kube-prom-username]

  type = "Opaque"
  metadata {
    name      = "kube-prom-auth"
    namespace = monitoring
  }

  data = {
    "auth" : "${random_string.kube-prom-username.result}:${bcrypt(random_string.kube-prom-password.result)}"
  }
}

resource "random_string" "kube-grafana-username" {
  length = 5
  special = false
}

resource "random_string" "kube-grafana-password" {
  length           = 16
  special          = true
  override_special = "_@"
}


resource "kubernetes_secret" "kube-grafana-basic-auth" {
  depends_on = [random_string.kube-grafana-password, random_string.kube-grafana-username]

  type = "Opaque"
  metadata {
    name      = "kube-grafana-basic-auth"
    namespace = "monitoring"
  }

  data = {
    "auth" : "${random_string.kube-grafana-username.result}:${bcrypt(random_string.kube-grafana-password.result)}"
  }
}

resource "random_string" "kube-alert-manager-username" {
  length = 5
  special = false
}


resource "random_string" "kube-alert-manager-password" {
  length           = 16
  special          = true
  override_special = "_@"
}

resource "kubernetes_secret" "kube-alert-manager-auth" {
  depends_on = [random_string.kube-alert-manager-password, random_string.kube-alert-manager-username]

  type = "Opaque"
  metadata {
    name      = "kube-alert-manager-auth"
    namespace = "monitoring"
  }

  data = {
    "auth" : "${random_string.kube-alert-manager-username.result}:${bcrypt(random_string.kube-alert-manager-password.result)}"
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
      kube-prom-host = "${var.kube_prom_host}"
      kube-grafana-host = "${var.kube_grafana_host}"
      alert-manager-host = "${var.alert_manager_host}"
    })
   ]
}
