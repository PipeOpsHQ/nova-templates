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

output "grafana_loki_auth_password" {
  sensitive = true
  value = module.grafana-loki.grafana_loki_auth_secret_password
}