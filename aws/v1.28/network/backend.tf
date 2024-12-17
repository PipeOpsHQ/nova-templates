terraform {
  backend "s3" {
    bucket         = "<replace>-owned-by-pipeops-do-not-delete"
    key            = "tf-module-state"
    region         = "eu-west-2"
    encrypt        = true
  }
}
