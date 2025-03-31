# Create cert-manager namespace
resource "kubernetes_namespace" "capsule_proxy" {
  metadata {
    name = var.k8s_namespace
  }
}


resource "helm_release" "capsule_proxy" {
  name       = var.helm_release_name
  repository = var.helm_repo_url
  chart      = var.helm_chart_name
  namespace  = var.k8s_namespace
  version    = var.helm_chart_version

  values = [
    <<-EOF
    autoscaling:
      enabled: false
      maxReplicas: 5
      minReplicas: 1
      targetCPUUtilizationPercentage: 80
    image:
      pullPolicy: IfNotPresent
      registry: ghcr.io
      repository: projectcapsule/capsule-proxy
      tag: ''
    replicaCount: 3
    ingress:
      annotations:
        cert-manager.io/cluster-issuer: letsencrypt-production
        kubernetes.io/tls-acme: 'true'
      className: nginx
      enabled: true
      hosts:
      - host: ${var.cluster_name}.pipeops.dev
        paths:
        - /
      tls:
      - hosts:
        - ${var.cluster_name}.pipeops.dev
        secretName: ${var.cluster_name}-tls
    options:
      enableSSL: false
    EOF
  ]

  depends_on = [
    kubernetes_namespace.capsule_proxy,
  ]
}