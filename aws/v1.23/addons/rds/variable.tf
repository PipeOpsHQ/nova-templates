variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "rds_apply_immediately" {
  type = bool
}

variable "rds_admin_user" {
  type = string
  sensitive = true
}

variable "rds_engine" {
  type = string
}

variable "rds_engine_version" {
  type = string
}

variable "rds_node_type" {
  type = string
}

variable "rds_multi_az" {
  type = string
}

variable "rds_storage_type" {
  type = string
}

variable "rds_allocated_storage" {
  type = number
  default = 20
}

variable "rds_admin_pass" {
  type = string
  sensitive = true
}

variable "rds_performance_insights_enabled" {
  type = bool
  default = true
}

variable "rds_dbname_override" {
  type = string
}

variable "rds_port" {
  type = string
  default = "3306"
}

variable "rds_backup_retention_period" {
  type = number
}

variable "rds_deletion_protection" {
  default = true
  type = bool
}

variable "rds_skip_final_snapshot" {
  type = bool
  default = true
}

variable "rds_storage_encrypted" {
  type = bool
  default = true
}

variable "rds_auto_minor_version_upgrade" {
  type = bool
  default = true
}

variable "rds_auto_major_version_upgrade" {
  type = bool
  default = false
}

variable "rds_performance_insights_retention_period" {
  type = string
  default = 7
}

variable "rds_public_accessibility" {
  type = bool
  default = false
}

variable "rds_maintenance_window" {
  type = string
}

variable "rds_backup_window" {
  type = string
}

variable "vpc_tag_name" {
  type = string
}

variable "subnet_tag_name" {
  type = string
}

variable "pipeops_aws_account" {
  description = "PipeOps WorkSpace Account"
}