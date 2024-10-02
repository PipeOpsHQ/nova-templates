variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "redis_shards_count" {
  type = number
  default = 1
}

variable "redis_replicas_count" {
  type = number
  default = 1
}

variable "redis_port" {
  type = string
  default = 6379
}

variable "redis_instance_type" {
  type = string
  default = "cache.t2.micro"
}

variable "redis_group_engine_version" {
  type = string
  default = "5.0.0"
}

variable "redis_snapshot_window" {
  type = string
}

variable "redis_maintenance_window" {
  type = string
}

variable "redis_auto_minor_version_upgrade" {
  type = bool
  default = true
}

variable "redis_at_rest_encryption_enabled" {
  type = bool
  default = false
}

variable "redis_transit_encryption_enabled" {
  type = bool
  default = false
}

variable "vpc_tag_name" {
  type = string
}

variable "subnet_tag_name" {
  type = string
}