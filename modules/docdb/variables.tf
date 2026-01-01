variable "docdb_subnetgroup_name" {
  description = "Name of the DocumentDB subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DocumentDB subnet group"
  type        = list(string)
}

variable "docdb_parameter_group_name" {
  description = "Name of the DocumentDB cluster parameter group"
  type        = string
}

variable "docdb_cluster_family" {
  description = "The family of the DocumentDB parameter group (e.g., docdb5.0)"
  type        = string
  default     = "docdb5.0"
}

variable "parameters_file" {
  description = "Path to JSON file containing DocumentDB cluster parameters"
  type        = string
  default     = "parameters.json"
}

variable "cluster_identifier_name" {
  description = "Cluster identifier for the DocumentDB cluster"
  type        = string
}

variable "master_username" {
  description = "Master username for the DocumentDB cluster"
  type        = string
}

variable "master_password" {
  description = "Master password for the DocumentDB cluster (use Secrets Manager in production)"
  type        = string
  sensitive   = true
}

variable "backup_retention_period" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7
}

variable "preferred_backup_window" {
  description = "Preferred backup window (e.g., 03:00-04:00)"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to associate with the cluster"
  type        = list(string)
}

variable "storage_encrypted" {
  description = "Enable storage encryption for the DocumentDB cluster"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when deleting the cluster"
  type        = bool
  default     = true
}

variable "number_of_instances" {
  description = "Number of DocumentDB instances to create in the cluster"
  type        = number
  default     = 1
}

variable "instance_class" {
  description = "Instance class for DocumentDB instances (e.g., db.r5.large)"
  type        = string
  default     = "db.r5.large"
}

variable "apply_immediately" {
  description = "Apply changes immediately or during maintenance window"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}