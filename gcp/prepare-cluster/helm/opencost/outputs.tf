output "opencost_auth_username" {
  sensitive = false
  value     = random_string.opencost_username.result
}

output "opencost_auth_password" {
  sensitive = false
  value     = random_string.opencost_password.result
}

output "opencost_host" {
  sensitive = false
  value     = "opencost-${var.cluster_name}.${var.dns_zone}"
}
