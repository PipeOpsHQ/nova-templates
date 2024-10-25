terraform {
  backend "s3" {
    bucket         = "<replaceAccountID>-owned-by-pipeops-do-not-delete"
    key            = "<replaceKey>-tf-module-state"
    region         = "eu-west-2"
    encrypt        = true
  }
}
