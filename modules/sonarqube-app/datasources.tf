data "aws_ssm_parameter" "db_host" {
  name = var.db_host_ssm_path
}

data "aws_ssm_parameter" "db_user" {
  name = var.db_user_ssm_path
}

data "aws_ssm_parameter" "db_password" {
  name = var.db_password_ssm_path
}

data "aws_ami" "amzlinux2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

data "aws_region" "current" {}

data "template_file" "user_data" {
  template = file("${path.module}/templates/user_data.tmpl.sh")
  vars = {
    db_host           = data.aws_ssm_parameter.db_host.value
    db_user           = data.aws_ssm_parameter.db_user.value
    db_password       = data.aws_ssm_parameter.db_password.value
    sonarqube_version = var.sonarqube_version
    aws_region        = data.aws_region.current.name
    aws_log_group     = aws_cloudwatch_log_group.this.name
    name              = local.prefix
  }
}
