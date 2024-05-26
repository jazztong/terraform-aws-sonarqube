# RDS MySQL Terraform Module

This Terraform module creates and manages an Amazon RDS MySQL database instance along with associated resources such as DB subnet group, parameter group, and security group.

## Requirements

- Terraform >= 1.0.0
- AWS Provider >= 3.0.0
- Random Provider >= 2.0.0

## Usage

```hcl
module "rds_mysql" {
  source = "../../modules/rds-mysql"

  db_name                         = "sonarqube"
  env                             = "dev"
  db_instance_class               = "db.t3.micro"
  multi_az                        = false
  vpc_id                          = "vpc-12345678"
  subnet_ids                      = ["subnet-12345678", "subnet-87654321"]
  db_username                     = "admin"
  db_engine_version               = "8.0"
  allocated_storage               = 20
  max_allocated_storage           = 100
  snapshot_identifier             = ""
  enabled_cloudwatch_logs_exports = ["error", "general", "slowquery"]
  option_group_name               = null
  parameter_overrides = {
    "max_connections" = "300"
  }
  db_password = null
}
```

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 3.0.0 |
| <a name="requirement_random"></a> [random](#requirement_random)          | >= 2.0.0 |

## Providers

| Name                                                      | Version  |
| --------------------------------------------------------- | -------- |
| <a name="provider_aws"></a> [aws](#provider_aws)          | >= 3.0.0 |
| <a name="provider_random"></a> [random](#provider_random) | >= 2.0.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                            | Type     |
| ------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance)                 | resource |
| [aws_db_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group)   | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group)         | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)           | resource |
| [aws_ssm_parameter.this_db_host](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter)     | resource |
| [aws_ssm_parameter.this_db_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.this_db_username](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [random_password.db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password)          | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)                   | resource |

## Inputs

| Name                                                                                                                                             | Description                                                                                              | Type           | Default                                                                   | Required |
| ------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------- | -------------- | ------------------------------------------------------------------------- | :------: |
| <a name="input_allocated_storage"></a> [allocated_storage](#input_allocated_storage)                                                             | The allocated storage size for the RDS instance                                                          | `number`       | `20`                                                                      |    no    |
| <a name="input_backup_retention_period"></a> [backup_retention_period](#input_backup_retention_period)                                           | The number of days to retain backups                                                                     | `number`       | `7`                                                                       |    no    |
| <a name="input_backup_window"></a> [backup_window](#input_backup_window)                                                                         | The daily time range during which automated backups are created                                          | `string`       | `"17:00-19:00"`                                                           |    no    |
| <a name="input_db_engine_version"></a> [db_engine_version](#input_db_engine_version)                                                             | The version of the PostgreSQL database engine to use                                                     | `string`       | `"15"`                                                                    |    no    |
| <a name="input_db_instance_class"></a> [db_instance_class](#input_db_instance_class)                                                             | The instance class to use                                                                                | `string`       | `"db.t3.micro"`                                                           |    no    |
| <a name="input_db_name"></a> [db_name](#input_db_name)                                                                                           | The default name of the database                                                                         | `string`       | `null`                                                                    |    no    |
| <a name="input_db_password"></a> [db_password](#input_db_password)                                                                               | The database admin password (optional, will auto-generate if not provided)                               | `string`       | `null`                                                                    |    no    |
| <a name="input_db_password_length"></a> [db_password_length](#input_db_password_length)                                                          | The length of the generated database password                                                            | `number`       | `16`                                                                      |    no    |
| <a name="input_db_username"></a> [db_username](#input_db_username)                                                                               | The database admin username                                                                              | `string`       | `"postgres"`                                                              |    no    |
| <a name="input_dynamic_parameter_group"></a> [dynamic_parameter_group](#input_dynamic_parameter_group)                                           | A map of dynamic parameters with their values. These parameters will use the immediate apply method.     | `map(string)`  | `{}`                                                                      |    no    |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled_cloudwatch_logs_exports](#input_enabled_cloudwatch_logs_exports)                   | List of log types to export to CloudWatch                                                                | `list(string)` | `[]`                                                                      |    no    |
| <a name="input_env"></a> [env](#input_env)                                                                                                       | The environment identifier (e.g., dev, prod)                                                             | `string`       | `"dev"`                                                                   |    no    |
| <a name="input_maintenance_window"></a> [maintenance_window](#input_maintenance_window)                                                          | The weekly time range during which system maintenance can occur, in UTC                                  | `string`       | `"sun:00:00-sun:03:00"`                                                   |    no    |
| <a name="input_max_allocated_storage"></a> [max_allocated_storage](#input_max_allocated_storage)                                                 | The maximum allocated storage size for the RDS instance                                                  | `number`       | `null`                                                                    |    no    |
| <a name="input_multi_az"></a> [multi_az](#input_multi_az)                                                                                        | Set to true to enable Multi-AZ RDS                                                                       | `bool`         | `false`                                                                   |    no    |
| <a name="input_name"></a> [name](#input_name)                                                                                                    | The name of the database, used as a prefix for all resources                                             | `string`       | n/a                                                                       |   yes    |
| <a name="input_option_group_name"></a> [option_group_name](#input_option_group_name)                                                             | The name of the DB option group                                                                          | `string`       | `null`                                                                    |    no    |
| <a name="input_performance_insights_enabled"></a> [performance_insights_enabled](#input_performance_insights_enabled)                            | Set to true to enable performance insights                                                               | `bool`         | `true`                                                                    |    no    |
| <a name="input_performance_insights_retention_period"></a> [performance_insights_retention_period](#input_performance_insights_retention_period) | The number of days to retain performance insights data, more than 7 days will bill extra charges         | `number`       | `7`                                                                       |    no    |
| <a name="input_sg_ingress_cidr_blocks"></a> [sg_ingress_cidr_blocks](#input_sg_ingress_cidr_blocks)                                              | The CIDR blocks to allow MySQL traffic from                                                              | `list(string)` | <pre>[<br> "0.0.0.0/0"<br>]</pre>                                         |    no    |
| <a name="input_snapshot_identifier"></a> [snapshot_identifier](#input_snapshot_identifier)                                                       | The DB snapshot identifier to restore from                                                               | `string`       | `null`                                                                    |    no    |
| <a name="input_static_parameter_group"></a> [static_parameter_group](#input_static_parameter_group)                                              | A map of static parameters with their values. These parameters will use the pending-reboot apply method. | `map(string)`  | `{}`                                                                      |    no    |
| <a name="input_subnet_ids"></a> [subnet_ids](#input_subnet_ids)                                                                                  | A list of subnet IDs to use for the DB subnet group                                                      | `list(string)` | n/a                                                                       |   yes    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                                                    | A map of tags to add to all resources                                                                    | `map(string)`  | <pre>{<br> "environment": "dev",<br> "managed_by": "Terraform"<br>}</pre> |    no    |
| <a name="input_vpc_id"></a> [vpc_id](#input_vpc_id)                                                                                              | The VPC ID to create the DB subnet group in                                                              | `string`       | n/a                                                                       |   yes    |

## Outputs

| Name                                                                                                           | Description |
| -------------------------------------------------------------------------------------------------------------- | ----------- |
| <a name="output_db_instance_endpoint"></a> [db_instance_endpoint](#output_db_instance_endpoint)                | n/a         |
| <a name="output_db_instance_id"></a> [db_instance_id](#output_db_instance_id)                                  | /outputs    |
| <a name="output_db_password_ssm_parameter"></a> [db_password_ssm_parameter](#output_db_password_ssm_parameter) | n/a         |
| <a name="output_db_username_ssm_parameter"></a> [db_username_ssm_parameter](#output_db_username_ssm_parameter) | n/a         |
| <a name="output_ssm_db_host"></a> [ssm_db_host](#output_ssm_db_host)                                           | n/a         |
| <a name="output_ssm_db_password"></a> [ssm_db_password](#output_ssm_db_password)                               | n/a         |
| <a name="output_ssm_db_username"></a> [ssm_db_username](#output_ssm_db_username)                               | n/a         |

<!-- END_TF_DOCS -->

# License

MIT License. See LICENSE for full details.

# Contributing

Contributions are welcome! Please open an issue or submit a pull request.

# Author

Jazz Tong

# Additional Resources

Terraform Documentation
AWS RDS Documentation
AWS RDS MySQL Documentation
