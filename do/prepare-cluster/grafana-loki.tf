
resource "aws_s3_bucket" "grafana-loki-bucket" {
  bucket = var.bucket_name

  tags = {
    Owner = var.cluster_name
  }
  force_destroy = true
}



module "grafana-loki" {
  source = "./helm/monitoring/grafana-loki"

}

################ End Configure Grafana-Loki  #######################################

