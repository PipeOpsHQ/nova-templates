module "ms_sample_redis" {
  source = "../microservices"

  env  = var.env
  name = var.name

  vpc_tag_filter = {
    "Name" = var.vpc_tag_name
  }

  # redis_enabled - Set to false to prevent the module from creating any redis resources
  redis_enabled = true

  # redis_cluster_id_override - Use only lowercase, numbers and -, _., only use when it needs to be different from `var.name`
  # redis_cluster_id_override = ""

  # redis_subnet_tag_filter sets the datasource to match the subnet_id's where the RDS will be located
  redis_subnet_tag_filter = {
     "Name" = var.subnet_tag_name
  }

  # redis_shards_count - Number of shards
  redis_shards_count = var.redis_shards_count

  # Number of replica nodes in each node group
  redis_replicas_count = var.redis_replicas_count

  # redis_port - Redis Port
  redis_port = var.redis_port

  # redis_instance_type - Redis instance type
  redis_instance_type = var.redis_instance_type

  # redis_group_engine_version - Redis engine version to be used
   redis_group_engine_version = var.redis_group_engine_version

  # redis_group_parameter_group_name - Redis parameter group name"
  # redis_group_parameter_group_name = "default.redis5.0.cluster.on"

  # redis_snapshot_window - Redis snapshot window
   redis_snapshot_window = var.redis_snapshot_window

  # redis_maintenance_window - Redis maintenance window
   redis_maintenance_window = var.redis_maintenance_window

  # redis_auto_minor_version_upgrade - Redis allow auto minor version upgrade
   redis_auto_minor_version_upgrade = var.redis_auto_minor_version_upgrade

  # redis_at_rest_encryption_enabled - Redis encrypt storage
   redis_at_rest_encryption_enabled = var.redis_at_rest_encryption_enabled
  # redis_transit_encryption_enabled - Redis encrypt transit TLS
   redis_transit_encryption_enabled = var.redis_transit_encryption_enabled

  tags = {
    Name = var.name
    Creator = "PipeOps Bot"
  }
}