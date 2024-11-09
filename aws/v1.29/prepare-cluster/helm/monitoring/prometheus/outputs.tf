output "prometheus_auth_secret_name" {
  sensitive = true
  value = var.cluster_name
}

output "prometheus_auth_secret_password" {
  sensitive = true
  value = random_string.password.result
}

