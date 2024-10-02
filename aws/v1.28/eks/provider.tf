# specify the provider and access details
provider "aws" {
  shared_credentials_files = [var.aws_config_path]  # Use shared_credentials_files instead
  profile                  = var.aws_profile
  region                   = var.aws_region
}