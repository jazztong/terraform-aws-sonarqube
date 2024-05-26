variable "name" {
  description = "The name of the project"
  type        = string
}

variable "env" {
  description = "The environment for the resources (e.g., dev, staging, prod)"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "volume_size" {
  description = "Volume size of root device"
  type        = number
  default     = 30
}

variable "volume_type" {
  description = "Volume type use in EC2,gp,io1,io2"
  type        = string
  default     = "gp2"
}

variable "ingress_cidr_blocks" {
  description = "A list of CIDR blocks to allow ingress traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "db_host_ssm_path" {
  description = "SSM parameter path for the database host"
  type        = string
}

variable "db_user_ssm_path" {
  description = "SSM parameter path for the database user"
  type        = string
}

variable "db_password_ssm_path" {
  description = "SSM parameter path for the database password"
  type        = string
}

variable "sonarqube_version" {
  description = "Version of SonarQube to use"
  type        = string
  default     = "10.5.1-community" # Latest LTS version at the time of writing
}
