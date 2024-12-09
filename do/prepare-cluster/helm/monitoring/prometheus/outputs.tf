output "prometheus_auth_secret_name" {
  sensitive = false
  value     = var.cluster_name
}

output "prometheus_auth_secret_password" {
  sensitive = false
  value     = random_string.password.result
}

