variable "name" {
  type        = string
  description = "Name of helm release"
  default     = "ingress-nginx"
}
variable "namespace" {
  type        = string
  description = "Name of namespace where nginx controller should be deployed"
  default     = "kube-system"
}

variable "chart_version" {
  type        = string
  description = "HELM Chart Version for nginx controller"
  default     = "4.7.1"
}

variable "ingress_class_name" {
  type        = string
  description = "IngressClass resource name"
  default     = "nginx"
}

variable "ingress_class_is_default" {
  type        = bool
  description = "IngressClass resource default for cluster"
  default     = true
}

variable "ip_address" {
  type        = string
  description = "External Static Address for loadbalancer (Doesn't work with AWS)"
  default     = null
}

variable "controller_kind" {
  type        = string
  description = "Controller type: DaemonSet, Deployment etc.."
  default     = "DaemonSet"
}
variable "controller_daemonset_useHostPort" {
  type        = bool
  description = "Also use host ports(80,443) for pods. Node Ports in services will be untouched"
  default     = false
}
variable "controller_service_externalTrafficPolicy" {
  type        = string
  description = "Traffic policy for controller. See docs."
  default     = "Local"
}
variable "controller_request_memory" {
  type        = number
  description = "Memory request for pod. Value in MB"
  default     = 140
}

variable "publish_service" {
  type        = bool
  description = "Publish LoadBalancer endpoint to Service"
  default     = true
}

variable "define_nodePorts" {
  type        = bool
  description = "By default service using NodePorts. It can be generated automatically, or you can assign this ports number"
  default     = true
}
variable "service_nodePort_http" {
  type        = string
  description = "NodePort number for http"
  default     = "32001"
}
variable "service_nodePort_https" {
  type        = string
  description = "NodePort number for https"
  default     = "32002"
}

variable "metrics_enabled" {
  type        = bool
  description = "Allow exposing metrics for prometheus-operator"
  default     = false
}

variable "disable_heavyweight_metrics" {
  type        = bool
  description = "Disable some 'heavyweight' or unnecessary metrics"
  default     = false
}

variable "additional_set" {
  description = "Add additional set for helm"
  default     = []
}
/*
variable "k8_config" {
  description = "path to k8 config"
  type = string

}*/