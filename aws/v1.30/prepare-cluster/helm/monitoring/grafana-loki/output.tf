output "grafana_loki_auth_password" {
  sensitive = false
  value     = random_string.grafana-loki-password.result
}

output "grafana-loki-host" {
  sensitive = false
  value = "grafana-loki-${var.cluster_name}.${var.dns_zone}"
}