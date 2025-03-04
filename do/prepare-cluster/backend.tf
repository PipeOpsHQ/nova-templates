terraform {
  backend "s3" {
    bucket = "pipeops-altschool-tfstate"
    key    = "do/components/tfstate"
    region = "eu-west-2"
    
  }
}