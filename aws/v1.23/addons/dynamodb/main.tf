module "ms_sample_iam_and_dynamodb" {
  source = "../microservices"

  env  = "playground"
  name = "sample"

  # iam_user_enabled creates an user with keys, with `iam_role_enabled` the user can switch into the role created by `iam_role_enabled`
  # For this example we're only creating a role with access to Dynamodb
  iam_user_enabled = false

  # iam_role_enabled creates a role.
  iam_role_enabled = true

  # Sample principal which can assume into this role
  #iam_role_principals_arns = ["arn:aws:iam::12374567890:root"]

  iam_inline_policies = [
    {
      name = "s3-access"
      statements = [
        {
          actions   = ["s3:ListBucket"]
          resources = ["arn:aws:s3:::test"]
        },
        {
          actions   = ["s3:get*"]
          resources = ["arn:aws:s3:::test/*"]
        }
      ]
    },
    {
      name = "kinesis-full-access"
      statements = [
        {
          actions   = ["kinesis:*"]
          resources = ["*"]
        },
      ]
    }
  ]


  # -------------------------------------------------------------------------------------------------
  # DynamoDB
  # This module re-uses an implementation of the module https://github.com/cloudposse/terraform-aws-dynamodb
  # -------------------------------------------------------------------------------------------------
  # `dynamodb_enabled` is set to true to enable Dynamodb
  dynamodb_enabled = true
  dynamodb_hash_key  = "HashKey"
  dynamodb_range_key = "RangeKey"

  # dynamodb_attributes = []
  # dynamodb_global_secondary_index_map = []
  # dynamodb_local_secondary_index_map = []

  tags = {
    Name = "sample"
  }
}

