resource "random_string" "kube_prom_username" {
  length = 5
  special = false
}

resource "random_string" "kube_prom_password" {
  length           = 16
  special          = true
  override_special = "_@"
}

resource "kubernetes_secret" "kube_prom_auth" {
  depends_on = [random_string.kube_prom_password, random_string.kube_prom_username]

  type = "Opaque"
  metadata {
    name      = "kube-prom-auth"
    namespace = "monitoring"
  }

  data = {
    "auth" : "${random_string.kube_prom_username.result}:${bcrypt(random_string.kube_prom_password.result)}"
  }
}

resource "random_string" "kube_grafana_username" {
  length = 5
  special = false
}

resource "random_string" "kube_grafana_password" {
  length           = 16
  special          = true
  override_special = "_@"
}


resource "kubernetes_secret" "kube_grafana_auth" {
  depends_on = [random_string.kube_grafana_password, random_string.kube_grafana_username]

  type = "Opaque"
  metadata {
    name      = "kube-grafana-auth"
    namespace = "monitoring"
  }

  data = {
    "auth" : "${random_string.kube_grafana_username.result}:${bcrypt(random_string.kube_grafana_password.result)}"
  }
}

resource "random_string" "kube_alert_manager_username" {
  length = 5
  special = false
}


resource "random_string" "kube_alert_manager_password" {
  length           = 16
  special          = true
  override_special = "_@"
}

resource "kubernetes_secret" "kube-alert-manager-auth" {
  depends_on = [random_string.kube_alert_manager_password, random_string.kube_alert_manager_username]

  type = "Opaque"
  metadata {
    name      = "kube-alert-manager-auth"
    namespace = "monitoring"
  }

  data = {
    "auth" : "${random_string.kube_alert_manager_username.result}:${bcrypt(random_string.kube_alert_manager_password.result)}"
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
  # create_namespace = "true"
  namespace = "monitoring"

  values = [ 
    templatefile("${path.module}/templates/values.yaml", {
      namespace = "monitoring",
      kube-prom-host     = "kube-prom-${var.cluster_name}.${var.dns_zone}"
      kube-grafana-host  = "kube-grafana-${var.cluster_name}.${var.dns_zone}"
      alert-manager-host = "kube-alert-manager-${var.cluster_name}.${var.dns_zone}"
      password = "${random_string.kube_grafana_password.result}"
    })
   ]
}
