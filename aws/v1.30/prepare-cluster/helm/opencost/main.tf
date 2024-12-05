resource "random_string" "opencost-password" {
  length           = 16
  special          = true
  override_special = "_@"
}

resource "kubernetes_secret" "opencost-basic-auth" {
  depends_on = [random_string.password]

  type = "Opaque"
  metadata {
    name      = "opencost-basic-auth"
    namespace = var.k8s_namespace
  }

  data = {
    username = "admin"
    password = random_string.opencost-password.result
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
      host = "opencost.pipeops.dev"
    })
  ]
}

