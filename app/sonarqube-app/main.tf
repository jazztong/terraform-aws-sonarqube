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

# main.tf
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}


module "sonarqube_app" {
  source = "../../modules/sonarqube-app"

  name                 = "sonar-app"
  env                  = "dev"
  vpc_id               = data.aws_vpc.default.id
  subnet_id            = data.aws_subnets.default.ids[0]
  db_host_ssm_path     = "/sonarqube-db/dev/host"
  db_user_ssm_path     = "/sonarqube-db/dev/username"
  db_password_ssm_path = "/sonarqube-db/dev/password"
  sonarqube_version    = "10.5.1-community"
  volume_size          = 30
}

output "result" {
  value = {
    public_ip   = module.sonarqube_app.public_ip
    instance_id = module.sonarqube_app.instance_id
  }
}
