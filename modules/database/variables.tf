variable "env_prefix" {
  description = "A prefix used to tag resources with the environment they are associated with"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  default     = "db.t3.micro"
}

variable "db_username" {
  description = "Username for the RDS database"
  default     = "dbadmin"
}

variable "database_name" {
  description = "The name of the database to create within the RDS instance"
  default     = "myappdb"
}

variable "database_subnets" {
  description = "A list of subnet IDs for the RDS database"
  type        = list(string)
}

variable "enable_multi_az" {
  description = "Set to true to enable Multi-AZ deployment for RDS instance"
  type        = bool
  default     = false  // Set default as false for cost-efficiency in non-critical environments
}


