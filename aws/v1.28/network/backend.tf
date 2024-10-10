/*terraform {
  backend "s3" {
    # bucket         = "pipeops-prod-cluster-tf"
    bucket = "nova-tf-templates"
    key            = "network-tf-state"
    region         = "eu-west-2"
    encrypt        = true
  }
} */