provider "http" {}

provider "aws" {
  region     = var.aws_region
  alias      = "virginia"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_session_token
}
