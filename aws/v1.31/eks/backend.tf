/*
terraform {
  backend "s3" {
    bucket  = "<replaceAccountID>-owned-by-pipeops-do-not-delete"
    key     = "<replaceKey>-tf-module-state"
    region  = "eu-west-2"
    encrypt = true
  }
}
*/
terraform {
  backend "s3" {
    bucket  = "nova-test-owned-by-pipeops-do-not-delete"
    key     = "aws-nova-1.31-tf-module-state-eks"
    region  = "eu-west-2"
    encrypt = true
  }
}
