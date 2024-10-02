terraform {
  backend "s3" {
    bucket         = "<replaceAccountID>-owned-by-pipeops-do-not-delete"
    key            = "<replaceKey>-tf-state"
    region         = "eu-west-2"
    encrypt        = true
  }
}

# specify the provider and access details
provider "aws" {
  shared_credentials_file = var.aws_config
  profile                 = var.AWS_PROFILE
  region                  = var.aws_region
}

module "rds" {
  source = "rds"

  rds_admin_pass      = var.database_password
  rds_admin_user      = var.database_user
  rds_dbname_override = var.database_name

  rds_port                 = var.database_port
  rds_public_accessibility = var.database_public

  rds_engine             = var.database_engine
  rds_engine_version     = var.database_engine_version
  rds_maintenance_window = var.database_maintenance_window

  rds_multi_az                   = var.addons_multi_az
  rds_node_type                  = var.database_instance_class
  rds_storage_type               = var.database_storage_type
  rds_allocated_storage          = var.database_allocated_storage
  rds_storage_encrypted          = var.database_storage_encrypted
  rds_auto_minor_version_upgrade = var.database_auto_minor_version_upgrade
  rds_auto_major_version_upgrade = var.database_auto_major_version_upgrade

  rds_apply_immediately       = var.database_immediate_upgrade
  rds_backup_retention_period = var.database_backup_retention
  rds_backup_window           = var.database_backup_window
  rds_skip_final_snapshot     = true
  rds_deletion_protection     = var.database_deletion_protection

  env  = var.addons_stage
  name = var.addons_name

  vpc_tag_name        = "${var.pipeops_aws_account}-vpc"
  subnet_tag_name     = "${var.pipeops_aws_account}-subnet"
  pipeops_aws_account = var.pipeops_aws_account
}