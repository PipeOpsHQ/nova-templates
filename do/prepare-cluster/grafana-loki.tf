
resource "aws_s3_bucket" "grafana-loki-bucket" {
  bucket = "${var.cluster_name}-grafana-loki"

  tags = {
    Owner = var.cluster_name
  }
}



module "grafana-loki" {
  source = "./helm/monitoring/grafana-loki"
  dns_zone = "pipeops.co"
  cluster_name = var.cluster_name
  aws_access_key_s3 = var.aws_access_key_s3
  aws_secret_key_s3 = var.aws_secret_key_s3
  aws_region_S3 = var.aws_region_S3
  
}

################ End Configure Grafana-Loki  #######################################

