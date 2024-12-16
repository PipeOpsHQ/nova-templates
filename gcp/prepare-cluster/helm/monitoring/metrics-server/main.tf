# Create cert-manager namespace
resource "helm_release" "metrics_server" {
  name       = var.helm_chart_name
  chart      = var.helm_chart_release_name
  repository = var.helm_chart_repo
  namespace  = var.namespace

  set {
    name  = "apiService.create"
    value = "true"
  }

  set {
    name  = "replicas"
    value = var.metric_server
  }

  set {
    name  = "app.kubernetes.io/managed-by"
    value = "pipeops-operator"
  }
}

variable "metric_server" {
  description = "metric sever replica's based on package"
  default     = 1
}