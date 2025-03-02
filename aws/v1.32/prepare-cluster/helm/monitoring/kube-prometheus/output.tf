output "kube_prom_auth_username" {
  sensitive = false
  value     = random_string.kube_prom_username.result
}

output "kube_prom_auth_password" {
  sensitive = false
  value     = random_string.kube_prom_password.result
}

output "kube_grafana_auth_username" {
  sensitive = false
  value     = random_string.kube_grafana_username.result
}

output "kube_grafana_auth_password" {
  sensitive = false
  value     = random_string.kube_grafana_password.result
}

output "kube_alert_manager_auth_username" {
  sensitive = false
  value     = random_string.kube_alert_manager_username.result
}

output "kube_alert_manager_auth_password" {
  sensitive = false
  value     = random_string.kube_alert_manager_password.result
}

output "kube_prom_host" {
  sensitive = false
  value     = "kube-prom-${var.cluster_name}.${var.dns_zone}"
}

output "kube_grafana_host" {
  sensitive = false
  value     = "kube-grafana-${var.cluster_name}.${var.dns_zone}"
}

output "alert_manager_host" {
  sensitive = false
  value     = "kube-alert-manager-${var.cluster_name}.${var.dns_zone}"
}