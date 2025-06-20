data "aws_iam_openid_connect_provider" "eks_oidc" {
  url = data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_s3_bucket" "grafana-loki-bucket" {
  count  = var.install_grafana_loki ? 1 : 0
  bucket = "${var.eks_cluster_name}-grafana-loki"

  tags = {
    Owner = var.eks_cluster_name
  }
  force_destroy = true
}


resource "aws_iam_role" "loki_irsa" {
  count = var.install_grafana_loki ? 1 : 0
  name  = "${var.eks_cluster_name}-loki-irsa"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = ""
        Effect = "Allow"
        Principal = {
          Federated = "${data.aws_iam_openid_connect_provider.eks_oidc.arn}"
          # Federated = "${data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].arn}"
        },
        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {
          StringEquals = {
            "${replace(data.aws_iam_openid_connect_provider.eks_oidc.url, "https://", "")}:sub" = "system:serviceaccount:monitoring:loki-sa"
          }
        }
      }
    ]
  })

  tags = {
    Name = var.eks_cluster_name

  }
  depends_on = [kubernetes_namespace.monitoring]
}

resource "aws_iam_role_policy" "loki_s3_policy" {
  count = var.install_grafana_loki ? 1 : 0
  name  = "loki-policy"
  role  = aws_iam_role.loki_irsa[0].name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        Effect = "Allow",
        Sid    = ""
        Resource = [
          "${aws_s3_bucket.grafana-loki-bucket[0].arn}",
          "${aws_s3_bucket.grafana-loki-bucket[0].arn}/*"
        ]
      }
    ]
  })
}

module "grafana-loki" {
  source       = "./helm/monitoring/grafana-loki"
  count        = var.install_grafana_loki ? 1 : 0
  cluster_name = var.eks_cluster_name
  dns_zone     = var.dns_zone
  region       = var.aws_region
  bucket_name  = "${var.eks_cluster_name}-grafana-loki"
  depends_on   = [module.ingress-controller, kubernetes_namespace.monitoring]
}

################ End Configure Grafana-Loki  #######################################