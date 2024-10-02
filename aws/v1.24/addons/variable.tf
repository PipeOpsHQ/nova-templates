
variable "addons_namespace" {
  description = "Addon NameSpace"
  type = string
}

variable "addons_stage" {
  description = "Addon Stage e.g prod, staging, dev"
  type = string
}

variable "addons_name" {
  description = "Addon Name"
  type = string
}

variable "addons_multi_az" {
  description = "Addon Db Multi Zone"
  type = string
}

variable "database_name" {
  description = "Database Name"
  type = string
}

variable "database_user" {
  description = "Database User"
  type = string
}

variable "database_port" {
  description = "Database Port"
  type = string
}

variable "database_deletion_protection" {
  type = bool
}

variable "database_password" {
  description = "Database Port"
  type = string
}

variable "database_storage_type" {
  description = "Database Storage Type"
  type = string
}

variable "database_allocated_storage" {
  description = "Database Allocated Storage"
  type = number
}

variable "database_storage_encrypted" {
  description = "Database Storage Encrypted"
  type = bool
}

variable "database_engine" {
  description = "Database Engine"
  type = string
}

variable "database_engine_version" {
  description = "Database Engine Version"
  type = string
}

variable "database_instance_class" {
  description = "Database Instance Class"
  type = string
}

variable "database_public" {
  description = "Make Database Publicly Accessible"
  type = bool
  default = false
}

variable "database_auto_minor_version_upgrade" {
  description = "Database Auto Minor Version Upgrade"
  type = bool
}

variable "database_auto_major_version_upgrade" {
  description = "Database Auto Major Version Upgrade"
  type = bool
}

variable "database_immediate_upgrade" {
  description = "Database Immediate Upgrade"
  type = bool
}

variable "database_maintenance_window" {
  description = "Database Maintenance Window"
}

variable "database_backup_retention" {
  description = "Database Backup Retention Period"
}

variable "database_backup_window" {
  description = "Database Backup Window"
}

variable "pipeops_aws_account" {
  type = string
}

variable "AWS_PROFILE" {
  description = "AWS PROFILE"
}

variable "aws_region" {
  description = "AWS region to launch servers."
}

variable "aws_config" {
  description = "path to aws config"
  type = string
}