
resource "kubernetes_namespace" "service_account_ns" {
  metadata {
    annotations = {
      name = var.service_account_ns
    }

    name = var.service_account_ns
  }
}

resource "kubernetes_service_account" "pipeops_admin" {
  metadata {
    name = "pipeops-admin"
    namespace = var.service_account_ns
  }
}

resource "kubernetes_secret" "pipeops_admin_secret" {
  metadata {
    name = "pipeops-admin-secret"
    namespace = var.service_account_ns
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.pipeops_admin.metadata.0.name
    }

  }

  type                           = "kubernetes.io/service-account-token"
  wait_for_service_account_token = true
}

resource "kubernetes_cluster_role_binding" "pipeops_cluster_role_binding" {
  metadata {
    name = "pipeops-cluster-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.pipeops_admin.metadata.0.name
    namespace = var.service_account_ns
  }
}