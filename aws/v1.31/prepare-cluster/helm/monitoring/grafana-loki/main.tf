resource "helm_release" "grafana-loki" {

  name = var.helm_release_name
  repository = var.helm_repo_url
  chart      = "grafana-loki"
  version = var.helm_chart_version
  namespace = "default"
  set {
    name = "global.defaultStorageClass"
    value = "gp2"
  }
  set {
    name = "serviceAccount.create"
    value = true
  }

  set {
    name = "serviceAccount.name"
    value = "loki-sa"
  }

  set {
    name = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "arn:aws:iam::022499013216:role/pipeops-loki-irsa"
  } 
  values = [
    templatefile("${path.module}/templates/values.yaml", {
      s3 = "s3://eu-west-2/grafana-loki-pipeops"
    })
  ]
}
