output "opencost_auth_secret_password" {
  sensitive = false
  value     = random_string.opencost-password.result
}

