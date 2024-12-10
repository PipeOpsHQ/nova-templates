output "grafana_loki_auth_secret_password" {
  sensitive = false
  value     = random_string.grafana-loki-password.result
}
/*
output "grafana-loki-auth-username" {
  sensitive = false
  value = random_string.grafana-loki-username.result
}
*/
output "grafana-loki-host" {
  sensitive = false
  value = var.grafana-loki-host
}