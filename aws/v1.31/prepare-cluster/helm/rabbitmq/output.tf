output "rabbitmq_secret_password" {
  sensitive = true
  value = random_string.rabbitmq_password.result
}

