resource "random_string" "opencost_username" {
  length  = 5
  special = false
}

resource "random_string" "opencost_password" {
  length           = 16
  special          = true
  override_special = "_@"
}

resource "kubernetes_secret" "opencost_basic_auth" {
  depends_on = [random_string.opencost_password, random_string.opencost_username]

  type = "Opaque"
  metadata {
    name      = "opencost-basic-auth"
    namespace = var.k8s_namespace
  }

  data = {
    "auth" : "${random_string.opencost_username.result}:${bcrypt(random_string.opencost_password.result)}"
  }
}


resource "random_string" "opencost_api_username" {
  length = 5
  special = false
}

resource "random_string" "opencost_api_password" {
  length           = 16
  special          = true
  override_special = "_@"
}

resource "kubernetes_secret" "opencost_api_basic_auth" {
  depends_on = [random_string.opencost_api_username, random_string.opencost_api_password]

  type = "Opaque"
  metadata {
    name      = "opencost-api-basic-auth"
    namespace = var.k8s_namespace
  }

  data = {
    "auth" : "${random_string.opencost_api_username.result}:${bcrypt(random_string.opencost_api_password.result)}"
  }
}

resource "helm_release" "opencost" {

  name       = var.helm_release_name
  repository = var.helm_repo_url
  chart      = var.helm_chart_name
  version    = var.helm_chart_version
  namespace  = var.k8s_namespace

  values = [
    templatefile("${path.module}/templates/values.yaml", {
      host = "opencost-${var.cluster_name}.${var.dns_zone}"
    })
  ]

}


resource "kubectl_manifest" "opencost_api_ingress" {
  yaml_body = <<-YAML
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: opencost-api
      namespace: default
      annotations:
        cert-manager.io/cluster-issuer: letsencrypt-production
        ingress.kubernetes.io/ssl-redirect: 'true'
        kubernetes.io/ingress.class: nginx
        kubernetes.io/tls-acme: 'true'
        nginx.ingress.kubernetes.io/auth-type: basic
        nginx.ingress.kubernetes.io/auth-secret: opencost-api-basic-auth
        nginx.ingress.kubernetes.io/auth-realm: 'Authentication Required'
    spec:
      ingressClassName: nginx
      tls:
        - hosts:
            - opencost-api-pipeops-altschool.pipeops.dev
          secretName: opencost-api-pipeops-altschool-pipeops-dev
      rules:
        - host: opencost-api-pipeops-altschool.pipeops.dev
          http:
            paths:
              - path: /
                pathType: Prefix
                backend:
                  service:
                    name: opencost
                    port:
                      name: http

  YAML

}
