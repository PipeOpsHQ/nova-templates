resource "random_string" "rabbitmq_password" {
  length           = 32
  special          = true
  override_special = "_@"
}

resource "kubernetes_secret" "rabbitmq-basic-auth" {
  type = "Opaque"
  metadata {
    name      = "rabbitmq-basic-auth"
    namespace = var.k8s_namespace
  }

  data = {
    "rabbitmq-password" : "${bcrypt(random_string.rabbitmq_password.result)}"
  }
}

resource "helm_release" "rabbitmq" {

  name = var.helm_release_name
  repository = var.helm_repo_url
  chart      = var.helm_chart_name
  version = var.helm_chart_version
  namespace = var.k8s_namespace

  set {
    name = "global.defaultStorageClass"
    value = "gp2"
  }
  set {
    name = "auth.existingPasswordSecret"
    value = kubernetes_secret.rabbitmq-basic-auth.metadata[0].name
  }
}

