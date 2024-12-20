
resource "aws_s3_bucket" "grafana-loki-bucket" {
  count  = var.install_grafana_loki ? 1 : 0
  bucket = var.bucket_name

  tags = {
    Owner = var.cluster_name
  }
}

module "grafana-loki" {
  source = "./helm/monitoring/grafana-loki"
  count  = var.install_grafana_loki ? 1 : 0
}

################ End Configure Grafana-Loki  #######################################

