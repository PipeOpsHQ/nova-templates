terraform {
  backend "s3" {
    bucket         = "pipeops-prod-cluster-tf"
    key            = "tf-v1.28-tf-state"
    region         = "eu-west-2"
    encrypt        = true
  }
}