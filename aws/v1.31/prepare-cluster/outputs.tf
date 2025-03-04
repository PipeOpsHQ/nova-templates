output "k8_dashboard_password" {
  value = module.kubernetes-dashboard[0].k8_dashboard_password
}
output "grafana_loki_host" {
  sensitive = false
  value     = module.grafana-loki[0].grafana-loki-host
}
output "grafana_loki_auth_username" {
  sensitive = false
  value     = module.grafana-loki[0].grafana_loki_auth_username
}
output "grafana_loki_auth_password" {
  sensitive = false
  value     = module.grafana-loki[0].grafana_loki_auth_password
}

output "kube_prom_host" {
  sensitive = false
  value     = module.kube-prometheus-stack[0].kube_prom_host
}

output "kube_prom_auth_username" {
  sensitive = false
  value     = module.kube-prometheus-stack[0].kube_prom_auth_username
}

output "kube_prom_auth_password" {
  sensitive = false
  value     = module.kube-prometheus-stack[0].kube_prom_auth_password
}

output "alert_manager_host" {
  sensitive = false
  value     = module.kube-prometheus-stack[0].alert_manager_host
}

output "kube_alert_manager_username" {
  sensitive = false
  value     = module.kube-prometheus-stack[0].kube_alert_manager_auth_username
}

output "kube_alert_manager_password" {
  sensitive = false
  value     = module.kube-prometheus-stack[0].kube_alert_manager_auth_password
}

output "opencost_host" {
  sensitive = false
  value     = module.opencost[0].opencost_host
}

output "opencost_auth_username" {
  sensitive = false
  value     = module.opencost[0].opencost_auth_username
}

output "opencost_auth_password" {
  sensitive = false
  value     = module.opencost[0].opencost_auth_password
}

output "kube_grafana_host" {
  sensitive = false
  value = module.kube-prometheus-stack[0].kube_grafana_host
}

output "kube_grafana_auth_username" {
  sensitive = false
  value = module.kube-prometheus-stack[0].kube_grafana_auth_username
}

output "kube_grafana_auth_password" {
  sensitive = false
  value     = module.kube-prometheus-stack[0].kube_grafana_auth_password
}
