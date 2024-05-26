# Configure the AWS provider
provider "aws" {
  region = "ap-southeast-1" # Singapore region
}

# Fetch the default VPC
data "aws_vpc" "default" {
  default = true
}

# Fetch the subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

module "rds_mysql" {
  source            = "../../modules/rds-postgresql"
  name              = "sonarqube-db"
  env               = "dev"
  db_instance_class = "db.t3.micro"
  multi_az          = true
  vpc_id            = data.aws_vpc.default.id
  subnet_ids        = data.aws_subnets.default.ids
  db_username       = "postgres"
  db_engine_version = "15"
  allocated_storage = 20
}

output "result" {
  value = {
    ssm_db_host     = module.rds_mysql.ssm_db_host
    ssm_db_password = module.rds_mysql.ssm_db_password
    ssm_db_username = module.rds_mysql.ssm_db_username
  }
}
