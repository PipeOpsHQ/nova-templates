locals {
  k8s_dashboard_password = random_string.password.result
}


resource "random_string" "password" {
  length           = 32
  special          = true
  override_special = "_@"
}


# Install the Kubernetes Dashboard using Helm
resource "helm_release" "k8s_dashboard" {
  name       = "kubernetes-dashboard"
  repository = var.helm_repo_url
  chart      = var.helm_chart_name
  version    = var.k8s_dashboard_version
  namespace  = var.namespace
  force_update = true


  values = [
    templatefile("${path.module}/templates/values.yaml", {
      cluster_name = var.cluster_name,
      host         = "dashboard.${var.cluster_name}.${var.dns_zone}",
      secret_name  = "${var.cluster_name}-dashboard-tls",
    })
  ]

}

output "k8s_dashboard_password" {
  value       = local.k8s_dashboard_password
  description = "Randomly generated password for Kubernetes dashboard"
  sensitive   = true
}
