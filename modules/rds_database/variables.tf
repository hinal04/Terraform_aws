variable "subnet_group_name" {
  description = "Name of the RDS DB subnet group"
  type        = string
}

variable "rds_subnets" {
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "rds_param_group_name" {
  description = "Name of the RDS parameter group"
  type        = string
}

variable "rds_param_group_family" {
  description = "The family of the DB parameter group (e.g., mysql8.0, postgres15)"
  type        = string
}

variable "parameter_file_path" {
  description = "Path to JSON file containing list of DB parameters"
  type        = string
  default     = ""
}

variable "db_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
}

variable "db_engine" {
  description = "Database engine (e.g., mysql, postgres)"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "Version of the database engine"
  type        = string
}

variable "db_instance_class" {
  description = "Instance class for the RDS DB (e.g., db.t3.micro)"
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
}

variable "db_max_allocated_storage" {
  description = "Maximum allocated storage for storage autoscaling (optional)"
  type        = number
  default     = null
}

variable "storage_type" {
  description = "Storage type (e.g., gp2, gp3, io1)"
  type        = string
  default     = "gp3"
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
}

variable "db_password" {
  description = "Master password for the database (use secrets manager in production)"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Initial database name to create"
  type        = string
  default     = null
}

variable "publicly_accessible" {
  description = "Whether the DB instance is publicly accessible"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "storage_encrypted" {
  description = "Enable storage encryption"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on deletion"
  type        = bool
  default     = true
}

variable "rds_security_groups" {
  description = "List of VPC security group IDs to associate with RDS"
  type        = list(string)
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Preferred backup window (UTC, e.g., 03:00-04:00)"
  type        = string
  default     = null
}

variable "maintenance_window" {
  description = "Preferred maintenance window (e.g., sun:04:00-sun:05:00)"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}