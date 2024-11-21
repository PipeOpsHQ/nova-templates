# Create cert-manager namespace
resource "kubernetes_namespace" "cert_manager_namespace" {
  metadata {
    name = var.namespace
  }
}

# Install cert-manager helm chart
resource "helm_release" "cert_manager" {
  name             = var.helm_release_name
  repository       = var.helm_repository_url
  chart            = var.helm_chart_name
  namespace        = var.namespace
  version = "v1.12.4"

  set {
    name  = "installCRDs"
    value = "true"
  }

#  set {
#    name  = "nodeSelector.kubernetes\\.io/os"
#    value = "true"
#  }

  values = [
    templatefile("${path.module}/values.yaml.tpl", {
      replica_count = var.replica_count
    })
  ]

  depends_on = [
    kubernetes_namespace.cert_manager_namespace
  ]
}

resource "kubectl_manifest" "cluster_issuer" {
  yaml_body = <<-YAML
    apiVersion: cert-manager.io/v1
    kind: ClusterIssuer
    metadata:
      name: letsencrypt-production
    spec:
      acme:
        # The ACME server URL
        server: https://acme-v02.api.letsencrypt.org/directory
        # Email address used for ACME registration
        email: ${var.acme_email}
        # Name of a secret used to store the ACME account private key
        privateKeySecretRef:
          name: letsencrypt-production
        # Enable the HTTP-01 challenge provider
        solvers:
        - http01:
            ingress:
              class: nginx
  YAML

  depends_on = [ helm_release.cert_manager ]
}

