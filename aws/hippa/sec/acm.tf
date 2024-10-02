resource "aws_acm_certificate" "cert" {
  domain_name       = var.certificate_domain
  validation_method = "DNS"

  tags = {
    Environment = "cert_domain"
  }

  lifecycle {
    create_before_destroy = true
  }
}