# Create cert-manager namespace
resource "kubernetes_namespace" "capsule" {
  metadata {
    name = var.k8s_namespace
  }
}

resource "kubernetes_namespace" "capsule_tenant_naamespace" {
  metadata {
    name = var.tenant_namespace
  }
}

resource "helm_release" "capsule" {
  name       = var.helm_release_name
  repository = var.helm_repo_url
  chart      = var.helm_chart_name
  namespace  = var.k8s_namespace
  version    = var.helm_chart_version

  set {
    name  = "manager.log.level"
    value = "4"
  }

  set {
    name  = "replicaCount"
    value = "5"
  }

  set {
    name  = "manager.nodeSelector.\"capsule.clastix.io/enabled\""
    value = "true"
  }

  set {
    name  = "capsule.userGroups"
    value = "{capsule.clastix.io,system:serviceaccounts:tenant-system}"
  }

  # Specify the configmap as per your requirement
  set {
    name  = "manager.configMap"
    value = "capsule-configuration"
  }

  # TLS Secret Name value
  set {
    name  = "manager.webhook.secret.name"
    value = "capsule-tls"
  }



  depends_on = [
    kubernetes_namespace.capsule,
  ]
}

resource "kubernetes_namespace" "production" {
  metadata {
    name = "staging"
  }
}
/*
resource "kubernetes_namespace" "pipeops" {
  metadata {
    name = "pipeops"
  }
}

*/