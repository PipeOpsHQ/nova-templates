output "k8_dashboard_password" {
  sensitive = true
  value     = module.kubernetes-dashboard[0].k8_dashboard_password
  depends_on = [ module.kubernetes-dashboard ]
}

output "grafana_loki_host" {
  sensitive = true
  value     = module.grafana-loki[0].grafana-loki-host
  depends_on = [ module.grafana-loki ]
}

output "grafana_loki_auth_password" {
  sensitive = true
  value     = module.grafana-loki[0].grafana_loki_auth_password
  depends_on = [ module.grafana-loki ]
}

output "grafana_loki_auth_username" {
  sensitive = true
  value     = module.grafana-loki[0].grafana_loki_auth_username
  depends_on = [ module.grafana-loki ]
}

output "kube_prom_host" {
  sensitive = true
  value     = module.kube-prometheus-stack[0].kube_prom_host
  depends_on = [ module.kube-prometheus-stack ]
}

output "kube_prom_auth_username" {
  sensitive = true
  value     = module.kube-prometheus-stack[0].kube_prom_auth_username
  depends_on = [ module.kube-prometheus-stack ]
}

output "kube_prom_auth_password" {
  sensitive = true
  value     = module.kube-prometheus-stack[0].kube_prom_auth_password
  depends_on = [ module.kube-prometheus-stack ]
}

output "alert_manager_host" {
  sensitive = true
  value     = module.kube-prometheus-stack[0].alert_manager_host
  depends_on = [ module.kube-prometheus-stack ]
}

output "kube_alert_manager_username" {
  sensitive = true
  value     = module.kube-prometheus-stack[0].kube_alert_manager_auth_username
  depends_on = [ module.kube-prometheus-stack ]
}

output "kube_alert_manager_password" {
  sensitive = true
  value     = module.kube-prometheus-stack[0].kube_alert_manager_auth_password
  depends_on = [ module.kube-prometheus-stack ]
}

output "opencost_host" {
  sensitive = true
  value     = module.opencost[0].opencost_host
  depends_on = [ module.opencost ]
}

output "opencost_auth_username" {
  sensitive = true
  value     = module.opencost[0].opencost_auth_username
  depends_on = [ module.opencost ]
}

output "opencost_auth_password" {
  sensitive = true
  value     = module.opencost[0].opencost_auth_password
  depends_on = [ module.opencost ]
}

output "kube_grafana_host" {
  sensitive = true
  value     = module.kube-prometheus-stack[0].kube_grafana_host
  depends_on = [ module.kube-prometheus-stack ]
}

output "kube_grafana_auth_username" {
  sensitive = true
  value     = module.kube-prometheus-stack[0].kube_grafana_auth_username
  depends_on = [ module.kube-prometheus-stack ]
}

output "kube_grafana_auth_password" {
  sensitive = true
  value     = module.kube-prometheus-stack[0].kube_grafana_auth_password
  depends_on = [ module.kube-prometheus-stack ]
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

output "load_balancer_endpoint" {
  value = module.ingress-controller[0].load_balancer_endpoint
  depends_on = [ module.ingress-controller ]
}