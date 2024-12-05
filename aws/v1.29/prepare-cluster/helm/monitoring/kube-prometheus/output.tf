output "kube_prom_auth_secret_password" {
  sensitive = false
  value     = random_string.kube-prom-password.result
}

output "kube-grafana_auth_secret_password" {
  sensitive = false
  value     = random_string.kube-grafana-password.result
}

