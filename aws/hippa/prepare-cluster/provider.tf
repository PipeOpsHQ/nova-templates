# specify the provider and access details
provider "aws" {
  shared_credentials_files = [var.aws_config]  # Use shared_credentials_files instead
  profile                  = var.AWS_PROFILE
  region                   = var.aws_region
}


provider "helm" {
  kubernetes {
    config_path = var.k8_config
  }
}
