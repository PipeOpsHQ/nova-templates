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
    name      = "pipeops-admin"
    namespace = var.service_account_ns
  }
}

resource "kubernetes_secret" "pipeops_admin_secret" {
  metadata {
    name      = "pipeops-admin-secret"
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

output "service_account_namespace" {
  description = "The namespace where the service account is created"
  value       = kubernetes_namespace.service_account_ns.metadata[0].name
}

output "service_account_name" {
  description = "The name of the created service account"
  value       = kubernetes_service_account.pipeops_admin.metadata[0].name
}

output "service_account_token" {
  description = "The token for the service account"
  value       = kubernetes_secret.pipeops_admin_secret.data["token"]
  sensitive   = true
}

output "service_account_secret_name" {
  description = "The name of the secret containing the service account token"
  value       = kubernetes_secret.pipeops_admin_secret.metadata[0].name
}

output "cluster_role_binding_name" {
  description = "The name of the cluster role binding"
  value       = kubernetes_cluster_role_binding.pipeops_cluster_role_binding.metadata[0].name
}