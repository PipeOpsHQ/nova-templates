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

output "kubernetes_dashboard_auth_password" {
  description = "kubernetes basic auth password"
  sensitive = true
  value = module.kubernetes-dashboard.k8_dashboard_password
}