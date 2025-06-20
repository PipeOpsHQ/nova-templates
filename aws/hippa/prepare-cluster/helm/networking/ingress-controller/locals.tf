locals {
  helm_chart            = "ingress-nginx"
  helm_repository       = "https://kubernetes.github.io/ingress-nginx"

  loadBalancerIP = var.ip_address == null ? [] : [
    {
      name  = "controller.service.loadBalancerIP"
      value = var.ip_address
    }
  ]

  metrics_enabled = var.metrics_enabled ? [
    {
      name  = "controller.metrics.enabled"
      value = "true"
    },
    {
      name  = "controller.metrics.serviceMonitor.enabled"
      value = "true"
    },
    {
      name  = "controller.metrics.serviceMonitor.additionalLabels.release"
      value = "kube-prometheus-stack"
    }
  ] : []

  controller_service_nodePorts = var.define_nodePorts ? [
    {
      name  = "controller.service.nodePorts.http"
      value = random_integer.http_port.result
    },
    {
      name  = "controller.service.nodePorts.https"
      value = random_integer.https_port.result
    }
  ] : []
}