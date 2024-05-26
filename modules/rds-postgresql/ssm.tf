
resource "aws_ssm_parameter" "this_db_password" {
  name  = "${local.parameter_path}/password"
  type  = "SecureString"
  value = var.db_password != null ? var.db_password : random_password.db_password.result

  tags = merge({
    Name = "${local.parameter_path}/password"
  }, var.tags)
}

resource "aws_ssm_parameter" "this_db_username" {
  name  = "${local.parameter_path}/username"
  type  = "String"
  value = var.db_username

  tags = merge({
    Name = "${local.parameter_path}/username"
  }, var.tags)
}

resource "aws_ssm_parameter" "this_db_host" {
  name  = "${local.parameter_path}/host"
  type  = "String"
  value = aws_db_instance.this.endpoint

  tags = merge({
    Name = "${local.parameter_path}/host"
  }, var.tags)
}
