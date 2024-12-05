/*
output "prometheus_basic_auth_name" {
  description = "promethues basic auth name"
  sensitive = true
  value = module.prometheus-server.prometheus_auth_secret_name
}

output "prometheus_basic_auth_password" {
  description = "promethues basic auth password"
  sensitive = true
  value = module.prometheus-server.prometheus_auth_secret_password
}
*/
output "kubernetes_dashboard_auth_password" {
  description = "kubernetes basic auth password"
  sensitive   = true
  value       = module.kubernetes-dashboard.k8_dashboard_password
}

output "rabbitmq_auth_password" {
  description = "kubernetes basic auth password"
  sensitive = true
  value = module.rabbitmq[0].rabbitmq_secret_password
}

output "opencost_auth_password" {
  sensitive = true
  value = module.opencost.opencost_auth_secret_password
}

output "kube_prom_auth_password" {
  sensitive = true
  value = module.kube-prometheus-stack.kube_prom_auth_secret_password
}
output "kube-prom-auth-username" {
  sensitive = true
  value = module.kube-prometheus-stack.kube-prom-auth-username
}

output "grafana_loki_auth_password" {
  sensitive = true
  value = module.grafana-loki.grafana_loki_auth_secret_password
}

output "grafana-loki-auth-username" {
  sensitive = true
  value = module.grafana-loki.grafana-loki-auth-username
}

output "grafana-loki-host" {
  sensitive = true
  value = module.grafana-loki.grafana-loki-host
}

output "kube-grafana-secret-password" {
  sensitive = true
  value = module.kube-prometheus-stack.kube-grafana_auth_secret_password
}
output "kube-grafana-auth-username" {
  sensitive = true
  value = module.kube-prometheus-stack.kube-grafana-auth-username
}

output "kube-alert-manager-username" {
  sensitive = true
  value = module.kube-prometheus-stack.kube-alert-manager-username
}

output "kube-alert-manager-password" {
  sensitive = true
  value = module.kube-prometheus-stack.kube-alert-manager-auth-password
}

output "opencost_username" {
  sensitive = true
  value = module.opencost.opencost_auth_username
}

output "opencost_password" {
  sensitive = true
  value = module.opencost.opencost_auth_secret_password
}

output "opencost_host" {
  sensitive = true
  value = module.opencost.opencost_host
}

output "kube_grafana_host" {
  sensitive = true
  value = module.kube-prometheus-stack.kube_grafana_host
}

output "kube_prom_host" {
  sensitive = true
  value = module.kube-prometheus-stack.kube_prom_host
}

output "alert_manager_host" {
  sensitive = true
  value = module.kube-prometheus-stack.alert_manager_host
}