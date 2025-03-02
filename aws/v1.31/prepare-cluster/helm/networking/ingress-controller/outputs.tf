output "name" {
  value = var.name
}
output "namespace" {
  value = var.namespace
}
output "ingress_class_name" {
  value = var.ingress_class_name
}
output "load_balancer_endpoint" {
  value = try(
    data.kubernetes_service.lb.status.0.load_balancer.0.ingress.0.ip,
    data.kubernetes_service.lb.status.0.load_balancer.0.ingress.0.hostname,
    "No endpoint found"
  )
}