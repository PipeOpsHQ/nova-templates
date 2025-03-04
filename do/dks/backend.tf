terraform {
  backend "s3" {
    bucket = "pipeops-altschool-tfstate"
    key    = "do/dks/tfstate"
    region = "eu-west-2"
    
  }
}