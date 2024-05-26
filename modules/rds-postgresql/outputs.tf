
///outputs
output "db_instance_id" {
  value = aws_db_instance.this.id
}

output "db_instance_endpoint" {
  value = aws_db_instance.this.endpoint
}

output "db_password_ssm_parameter" {
  value = aws_ssm_parameter.this_db_password.name
}

output "db_username_ssm_parameter" {
  value = aws_ssm_parameter.this_db_username.name
}

output "ssm_db_password" {
  value = aws_ssm_parameter.this_db_password.name
}

output "ssm_db_host" {
  value = aws_ssm_parameter.this_db_host.name
}

output "ssm_db_username" {
  value = aws_ssm_parameter.this_db_username.name
}
