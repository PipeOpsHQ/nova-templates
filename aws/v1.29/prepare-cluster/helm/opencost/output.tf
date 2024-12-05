output "opencost_auth_secret_password" {
  sensitive = false
  value     = random_string.opencost-password.result
}

output "opencost_auth_username" {
  sensitive = true
  value = random_string.opencost_username.result
}