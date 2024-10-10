terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.7.0"
    }
  }
}

provider "aws" {
  alias  = "us_east"
  region = "us-east-1"
}

provider "aws" {
  region                   = "eu-west-2"
}

data "aws_ecrpublic_authorization_token" "token" {
  provider = aws.us-east
}