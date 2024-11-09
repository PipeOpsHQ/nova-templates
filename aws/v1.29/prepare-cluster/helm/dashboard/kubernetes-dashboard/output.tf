output "k8_dashboard_password" {
  sensitive = true
  value = random_string.password.result
}