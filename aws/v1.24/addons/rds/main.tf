data "aws_vpc" "selected" {
  tags = {
    Name = "${var.pipeops_aws_account}-vpc"
  }
}

data "aws_subnet_ids" "selected" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = ["${var.pipeops_aws_account}-subnet"]
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.env}-${var.name}"
  subnet_ids = data.aws_subnet_ids.selected.ids

  tags = {
    Name = "${var.env}-${var.name}"
  }
}

resource "aws_security_group" "rds_security_group" {
  name   = "${var.env}-${var.name}"
  vpc_id = data.aws_vpc.selected.id

  ingress {
    from_port   = var.rds_port
    to_port     = var.rds_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = var.rds_port
    to_port     = var.rds_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.name}"
  }
}

#resource "aws_db_parameter_group" "rds_parameter_group" {
#  name   = "${var.env}-${var.name}"
#family = var.rds_engine == "postgres" ? "postgres13" : "mysql8.0"
#
#  parameter {
#    name  = "log_connections"
#    value = "1"
#  }
#}

resource "aws_db_instance" "rds_aws_db_instance" {
  identifier             = "${var.env}-${var.name}"
  instance_class         = var.rds_node_type
  allocated_storage      = var.rds_allocated_storage
  storage_encrypted = var.rds_storage_encrypted

  engine                 = var.rds_engine
  name                   = var.rds_dbname_override
  engine_version         = var.rds_engine_version
  username               = var.rds_admin_user
  password               = var.rds_admin_pass

  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
#  parameter_group_name   = aws_db_parameter_group.rds_parameter_group.name
  publicly_accessible    = var.rds_public_accessibility
  skip_final_snapshot    = var.rds_skip_final_snapshot
  multi_az = var.rds_multi_az


  deletion_protection = var.rds_deletion_protection
  apply_immediately = var.rds_apply_immediately
  allow_major_version_upgrade = var.rds_auto_major_version_upgrade
#  allow_minor_version_upgrade = var.rds_auto_minor_version_upgrade


  backup_retention_period = var.rds_backup_retention_period
#  backup_window = var.rds_backup_window
  maintenance_window = var.rds_maintenance_window
  copy_tags_to_snapshot = true

  performance_insights_retention_period = var.rds_performance_insights_retention_period
  performance_insights_enabled = var.rds_performance_insights_enabled

  tags = {
    Name = "${var.env}-${var.name}"
    Creator = "PipeOps Bot"
  }

}