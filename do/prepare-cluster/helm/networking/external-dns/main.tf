resource "random_string" "random-name" {
  length  = 12
  upper   = false
  lower   = true
  special = false
}

resource "helm_release" "external-dns" {

  name = random_string.random-name.result

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  namespace  = "default"

}
