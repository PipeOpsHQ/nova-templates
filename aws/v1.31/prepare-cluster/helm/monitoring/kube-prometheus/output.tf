output "kube_prom_auth_secret_password" {
  sensitive = false
  value     = random_string.kube-prom-password.result
}

output "kube-prom-auth-username" {
  sensitive = false
  value = random_string.kube-prom-username.result
}

output "kube-grafana_auth_secret_password" {
  sensitive = false
  value     = random_string.kube-grafana-password.result
}

output "kube-grafana-auth-username" {
  sensitive = false
  value = random_string.kube-grafana-username.result
}

output "kube-alert-manager-username" {
  sensitive = false
  value = random_string.kube-alert-manager-username.result
}

output "kube-alert-manager-auth-password" {
  sensitive = false
  value = random_string.kube-alert-manager-password.result
}

output "kube_prom_host" {
  sensitive = true
  value = var.kube_prom_host
}

output "kube_grafana_host" {
  sensitive = true
  value = var.kube_grafana_host
}

output "alert_manager_host" {
  sensitive = true
  value = var.alert_manager_host
}