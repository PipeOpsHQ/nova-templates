output "grafana_loki_auth_secret_password" {
  sensitive = false
  value     = random_string.grafana-loki-password.result
}
