variable "cluster_subnet_group_name" {
  description = "Name of the DB subnet group for the RDS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "rds_cluster_param_group_name" {
  description = "Name of the DB cluster parameter group"
  type        = string
}

variable "rds_cluster_param_group_family" {
  description = "Family of the DB cluster parameter group (e.g., aurora-mysql8.0, docdb5.0)"
  type        = string
}

variable "parameter_file_path" {
  description = "Path to the JSON file containing cluster parameters"
  type        = string
}

variable "cluster_identifier" {
  description = "Identifier for the RDS cluster"
  type        = string
}

variable "engine" {
  description = "Database engine (e.g., aurora-mysql, aurora-postgresql, docdb)"
  type        = string
}

variable "engine_version" {
  description = "Engine version for the RDS cluster"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones for the cluster (optional for Aurora)"
  type        = list(string)
  default     = []
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to associate with the cluster"
  type        = list(string)
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before deletion"
  type        = bool
  default     = true
}

variable "preferred_backup_window" {
  description = "Preferred backup window (e.g., 03:00-04:00)"
  type        = string
  default     = null
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups"
  type        = number
  default     = 7
}

variable "preferred_maintenance_window" {
  description = "Preferred maintenance window (e.g., sun:04:00-sun:05:00)"
  type        = string
  default     = null
}

variable "number_of_instances_in_the_cluster" {
  description = "Number of cluster instances to create"
  type        = number
  default     = 1
}

variable "identifier" {
  description = "Base identifier for cluster instances (will append -1, -2, etc.)"
  type        = string
}

variable "instance_class" {
  description = "Instance class for the cluster instances (e.g., db.r6g.large)"
  type        = string
}

variable "publicly_accessible" {
  description = "Whether the cluster instances are publicly accessible"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}