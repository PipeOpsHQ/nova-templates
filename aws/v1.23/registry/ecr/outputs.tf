output "access_key_id" {
  value = aws_iam_access_key.ecr_iam_access_key.id
}

output "secret_access_key" {
  value = aws_iam_access_key.ecr_iam_access_key.secret
}

output "registry_name" {
  value = aws_ecr_repository.ecr_repository.name
}

output "registry_url" {
  value = aws_ecr_repository.ecr_repository.repository_url
}