resource "random_string" "opencost_username" {
  length = 5
  special = false
}

resource "random_string" "opencost_password" {
  length           = 16
  special          = true
  override_special = "_@"
}

resource "kubernetes_secret" "opencost-basic-auth" {
  depends_on = [random_string.opencost_password, random_string.opencost_username]

  type = "Opaque"
  metadata {
    name      = "opencost-basic-auth"
    namespace = var.k8s_namespace
  }

  data = {
    "auth" : "${random_string.opencost_username.result}:${bcrypt(random_string.opencost_password.result)}"
  }
}


resource "helm_release" "opencost" {

  name = var.helm_release_name
  repository = var.helm_repo_url
  chart      = var.helm_chart_name
  version = var.helm_chart_version
  namespace = var.k8s_namespace

  values = [
    templatefile("${path.module}/templates/values.yaml", {
      host = "opencost-${var.cluster_name}.${var.dns_zone}"
    })
  ]
}

