
///variables
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    managed_by  = "Terraform"
    environment = "dev"
  }
}

variable "sg_ingress_cidr_blocks" {
  description = "The CIDR blocks to allow MySQL traffic from"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "db_name" {
  description = "The default name of the database"
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the database, used as a prefix for all resources"
  type        = string
}

variable "env" {
  description = "The environment identifier (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "db_instance_class" {
  description = "The instance class to use"
  type        = string
  default     = "db.t3.micro"
  validation {
    condition     = contains(["db.t3.micro", "db.t3.small", "db.t3.medium"], var.db_instance_class)
    error_message = "The db_instance_class must be one of the following: db.t3.micro, db.t3.small, db.t3.medium"
  }
}

variable "multi_az" {
  description = "Set to true to enable Multi-AZ RDS"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "The VPC ID to create the DB subnet group in"
  type        = string
  validation {
    condition     = length(var.vpc_id) > 0
    error_message = "The vpc_id must not be empty"
  }
}

variable "subnet_ids" {
  description = "A list of subnet IDs to use for the DB subnet group"
  type        = list(string)
  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "You must specify at least two subnet IDs"
  }
}

variable "db_username" {
  description = "The database admin username"
  type        = string
  default     = "postgres"
}

variable "db_password_length" {
  description = "The length of the generated database password"
  type        = number
  default     = 16
  validation {
    condition     = var.db_password_length >= 12 && var.db_password_length <= 128
    error_message = "The db_password_length must be between 12 and 128 characters"
  }
}

variable "db_password" {
  description = "The database admin password (optional, will auto-generate if not provided)"
  type        = string
  default     = null
}

variable "db_engine_version" {
  description = "The version of the PostgreSQL database engine to use"
  type        = string
  default     = "15"
  validation {
    condition     = contains(["13", "14", "15"], var.db_engine_version)
    error_message = "The db_engine_version must be one of the following: 13, 14, 15"
  }
}

variable "allocated_storage" {
  description = "The allocated storage size for the RDS instance"
  type        = number
  default     = 20
  validation {
    condition     = var.allocated_storage >= 20 && var.allocated_storage <= 6144
    error_message = "The allocated_storage must be between 20 and 6144 GB"
  }
}

variable "max_allocated_storage" {
  description = "The maximum allocated storage size for the RDS instance"
  type        = number
  default     = null
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to CloudWatch"
  type        = list(string)
  default     = []
  validation {
    condition     = alltrue([for log in var.enabled_cloudwatch_logs_exports : contains(["error", "general", "slowquery"], log)])
    error_message = "The enabled_cloudwatch_logs_exports must be one or more of the following: error, general, slowquery"
  }
}

variable "option_group_name" {
  description = "The name of the DB option group"
  type        = string
  default     = null
}

variable "static_parameter_group" {
  description = "A map of static parameters with their values. These parameters will use the pending-reboot apply method."
  type        = map(string)
  default     = {}
}

variable "dynamic_parameter_group" {
  description = "A map of dynamic parameters with their values. These parameters will use the immediate apply method."
  type        = map(string)
  default     = {}
}

variable "backup_retention_period" {
  description = "The number of days to retain backups"
  type        = number
  default     = 7
  validation {
    condition     = var.backup_retention_period >= 1 && var.backup_retention_period <= 35
    error_message = "The backup_retention_period must be between 1 and 35 days"
  }
}

variable "backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
  default     = "17:00-19:00"
}

variable "maintenance_window" {
  description = "The weekly time range during which system maintenance can occur, in UTC"
  type        = string
  default     = "sun:00:00-sun:03:00"
}

variable "snapshot_identifier" {
  description = "The DB snapshot identifier to restore from"
  type        = string
  default     = null
}

variable "performance_insights_enabled" {
  description = "Set to true to enable performance insights"
  default     = true
}

variable "performance_insights_retention_period" {
  description = "The number of days to retain performance insights data, more than 7 days will bill extra charges"
  default     = 7
}