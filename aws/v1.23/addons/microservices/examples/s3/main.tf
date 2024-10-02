module "ms_sample_s3" {
  source = "../../microservice"

  env  = "playground"
  name = "tests3"

  # iam_role_enabled creates a role.
  iam_role_enabled = true

  s3_enabled    = true
  s3_identifier = "this-is-the-bucket-name"

  s3_lifecycle_rules = [
    {
      id      = "all-cleanup"
      enabled = true
      prefix  = ""
      expiration_days = 90
    },
    {
      id      = "tmp"
      enabled = true
      prefix  = "tmp/"
      expiration_days = 1
    }
  ]

  tags = {
    Name = "sample"
  }
}
