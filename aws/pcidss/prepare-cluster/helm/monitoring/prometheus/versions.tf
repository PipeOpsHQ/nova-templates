provider "helm" {
  kubernetes {
    config_path = var.k8_config
  }
}