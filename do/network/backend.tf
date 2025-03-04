terraform {
  backend "s3" {
    bucket = "pipeops-altschool-tfstate"
    key    = "do/network/tfstate"
    region = "eu-west-2"
    
  }
}