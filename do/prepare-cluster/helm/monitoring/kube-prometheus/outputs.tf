output "kube_prom_auth_username" {
  sensitive = false
  value     = random_string.kube_prom_username.result
}

output "kube_prom_auth_password" {
  sensitive = false
  value     = random_string.kube_prom_password.result
}

output "kube_grafana_auth-username" {
  sensitive = false
  value     = random_string.kube_grafana_username.result
}

output "kube_grafana_auth_password" {
  sensitive = false
  value     = random_string.kube_grafana_password.result
}

output "kube_alert_manager_username" {
  sensitive = false
  value     = random_string.kube_alert_manager_username.result
}

output "kube_alert_manager-auth-password" {
  sensitive = false
  value     = random_string.kube_alert_manager_password.result
}

output "kube_prom_host" {
  sensitive = true
  value     = var.kube_prom_host
}

output "kube_grafana_host" {
  sensitive = true
  value     = var.kube_grafana_host
}

output "alert_manager_host" {
  sensitive = true
  value     = var.alert_manager_host
}