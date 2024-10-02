provider "helm" {
  kubernetes {
    config_path = var.k8_config
  }
}

# Generate a random vm name
resource "random_string" "random-name" {
  length  = 12
  upper   = false
  number  = false
  lower   = true
  special = false
}

resource "helm_release" "external-dns" {

  name = random_string.random-name.result

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  namespace  = "default"

  set {
    name  = "awsRegion"
    value = var.aws_region
  }
}
