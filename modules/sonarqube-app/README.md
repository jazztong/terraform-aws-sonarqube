# SonarQube Terraform Module

This module deploys a SonarQube instance on an EC2 instance using Docker Compose, attaches an Elastic IP, and configures security groups.

## Requirements

- AWS account
- Terraform

## Usage

```hcl
module "sonarqube" {
  source        = "./modules/sonarqube"
  vpc_id        = "<vpc-id>"
  subnet_id     = "<subnet-id>"
  instance_type = "t3.medium"
  key_name      = "<key-name>"
  db_host       = "<db-host>"
  db_port       = "3306"
  db_name       = "<db-name>"
  db_user       = "<db-user>"
  db_password   = "<db-password>"
  ingress_cidr_blocks = ["<your-ingress-cidr>"]
}
```

<!-- BEGIN_TF_DOCS -->

## Requirements

No requirements.

## Providers

| Name                                                            | Version |
| --------------------------------------------------------------- | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws)                | n/a     |
| <a name="provider_template"></a> [template](#provider_template) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                          | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group)             | resource    |
| [aws_cloudwatch_log_stream.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream)           | resource    |
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)                                               | resource    |
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile)             | resource    |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                     | resource    |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource    |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)                                     | resource    |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                         | resource    |
| [aws_ami.amzlinux2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)                                       | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region)                                   | data source |
| [aws_ssm_parameter.db_host](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter)                     | data source |
| [aws_ssm_parameter.db_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter)                 | data source |
| [aws_ssm_parameter.db_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter)                     | data source |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file)                           | data source |

## Inputs

| Name                                                                                          | Description                                                  | Type           | Default                           | Required |
| --------------------------------------------------------------------------------------------- | ------------------------------------------------------------ | -------------- | --------------------------------- | :------: |
| <a name="input_db_host_ssm_path"></a> [db_host_ssm_path](#input_db_host_ssm_path)             | SSM parameter path for the database host                     | `string`       | n/a                               |   yes    |
| <a name="input_db_password_ssm_path"></a> [db_password_ssm_path](#input_db_password_ssm_path) | SSM parameter path for the database password                 | `string`       | n/a                               |   yes    |
| <a name="input_db_user_ssm_path"></a> [db_user_ssm_path](#input_db_user_ssm_path)             | SSM parameter path for the database user                     | `string`       | n/a                               |   yes    |
| <a name="input_env"></a> [env](#input_env)                                                    | The environment for the resources (e.g., dev, staging, prod) | `string`       | n/a                               |   yes    |
| <a name="input_ingress_cidr_blocks"></a> [ingress_cidr_blocks](#input_ingress_cidr_blocks)    | A list of CIDR blocks to allow ingress traffic               | `list(string)` | <pre>[<br> "0.0.0.0/0"<br>]</pre> |    no    |
| <a name="input_instance_type"></a> [instance_type](#input_instance_type)                      | The EC2 instance type                                        | `string`       | `"t3.medium"`                     |    no    |
| <a name="input_name"></a> [name](#input_name)                                                 | The name of the project                                      | `string`       | n/a                               |   yes    |
| <a name="input_sonarqube_version"></a> [sonarqube_version](#input_sonarqube_version)          | Version of SonarQube to use                                  | `string`       | `"10.5.1-community"`              |    no    |
| <a name="input_subnet_id"></a> [subnet_id](#input_subnet_id)                                  | The subnet ID                                                | `string`       | n/a                               |   yes    |
| <a name="input_tags"></a> [tags](#input_tags)                                                 | A map of tags to assign to resources                         | `map(string)`  | `{}`                              |    no    |
| <a name="input_volume_size"></a> [volume_size](#input_volume_size)                            | Volume size of root device                                   | `number`       | `30`                              |    no    |
| <a name="input_volume_type"></a> [volume_type](#input_volume_type)                            | Volume type use in EC2,gp,io1,io2                            | `string`       | `"gp2"`                           |    no    |
| <a name="input_vpc_id"></a> [vpc_id](#input_vpc_id)                                           | The VPC ID                                                   | `string`       | n/a                               |   yes    |

## Outputs

| Name                                                                 | Description |
| -------------------------------------------------------------------- | ----------- |
| <a name="output_instance_id"></a> [instance_id](#output_instance_id) | n/a         |
| <a name="output_public_ip"></a> [public_ip](#output_public_ip)       | n/a         |

<!-- END_TF_DOCS -->

# License

MIT License. See LICENSE for full details.

# Contributing

Contributions are welcome! Please open an issue or submit a pull request.

# Author

Jazz Tong
