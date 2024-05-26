resource "aws_db_subnet_group" "this" {
  name       = "${local.resource_prefix}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge({
    Name = "${local.resource_prefix}-subnet-group"
  }, var.tags)
}

resource "random_password" "db_password" {
  length           = var.db_password_length
  special          = true
  override_special = "_%-"
  keepers = {
    db_password = var.db_password != null ? var.db_password : ""
  }
}

resource "random_string" "suffix" {
  length  = 6
  special = false
}

resource "aws_db_parameter_group" "this" {
  name        = "${local.resource_prefix}-parameter-group"
  family      = "postgres${var.db_engine_version}"
  description = "Custom parameter group for ${local.resource_prefix}"

  dynamic "parameter" {
    for_each = merge(
      {
        work_mem                   = { value = "65536", apply_method = "immediate" } # 64MB
        log_min_duration_statement = { value = "1000", apply_method = "immediate" }
        timezone                   = { value = "UTC", apply_method = "immediate" }
        client_encoding            = { value = "UTF8", apply_method = "immediate" }
      },
      { for k, v in var.static_parameter_group : k => merge(v, { apply_method = "pending-reboot" }) },
      { for k, v in var.dynamic_parameter_group : k => merge(v, { apply_method = "immediate" }) }
    )
    content {
      name         = parameter.key
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  tags = merge({
    Name = "${local.resource_prefix}-parameter-group"
  }, var.tags)
}

resource "aws_db_instance" "this" {
  allocated_storage               = var.allocated_storage
  max_allocated_storage           = var.max_allocated_storage
  storage_type                    = "gp2"
  engine                          = "postgres"
  engine_version                  = var.db_engine_version
  instance_class                  = var.db_instance_class
  identifier                      = "${local.resource_prefix}-db"
  username                        = var.db_username
  password                        = aws_ssm_parameter.this_db_password.value
  db_subnet_group_name            = aws_db_subnet_group.this.name
  vpc_security_group_ids          = [aws_security_group.this.id]
  multi_az                        = var.multi_az
  maintenance_window              = var.maintenance_window
  backup_retention_period         = var.backup_retention_period
  backup_window                   = var.backup_window
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  option_group_name               = var.option_group_name
  parameter_group_name            = aws_db_parameter_group.this.name
  storage_encrypted               = true
  db_name                         = var.db_name
  copy_tags_to_snapshot           = true
  apply_immediately               = false

  skip_final_snapshot       = false
  final_snapshot_identifier = "${local.resource_prefix}-final-snapshot-${random_string.suffix.result}"

  snapshot_identifier = var.snapshot_identifier != "" ? var.snapshot_identifier : null

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period

  tags = merge({
    Name = "${local.resource_prefix}-mysql-db"
  }, var.tags)

  depends_on = [aws_ssm_parameter.this_db_password]
}
