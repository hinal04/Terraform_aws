variable "create" {
  description = "Whether to create the ElastiCache Serverless Cache"
  type        = bool
  default     = true
}

variable "engine" {
  description = "Name of the cache engine (redis or valkey)"
  type        = string
  default     = "redis"
}

variable "cache_name" {
  description = "Name of the serverless cache"
  type        = string
}

variable "cache_usage_limits" {
  description = "Cache usage limits configuration (data_storage and ecpu_per_second)"
  type = list(object({
    data_storage = optional(object({
      maximum = optional(number)
      minimum = optional(number)
      unit    = optional(string, "GB")
    }))
    ecpu_per_second = optional(object({
      maximum = optional(number)
      minimum = optional(number)
    }))
  }))
  default = []
}

variable "daily_snapshot_time" {
  description = "Daily time to take automatic snapshot, in UTC (HH:MM)"
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the serverless cache"
  type        = string
  default     = null
}

variable "kms_key_id" {
  description = "ARN of the KMS key used for encryption at rest"
  type        = string
  default     = null
}

variable "major_engine_version" {
  description = "Major version of the cache engine (e.g., 7)"
  type        = string
}

variable "security_group_ids" {
  description = "List of VPC security group IDs"
  type        = list(string)
}

variable "snapshot_arns_to_restore" {
  description = "List of ARNs of snapshots to restore from"
  type        = list(string)
  default     = []
}

variable "snapshot_retention_limit" {
  description = "Number of days to retain automated snapshots"
  type        = number
  default     = null
}

variable "subnet_ids" {
  description = "List of VPC subnet IDs for the cache"
  type        = list(string)
}

variable "user_group_id" {
  description = "User group ID to associate with the cache"
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Custom timeouts for create, update, and delete operations"
  type = object({
    create = optional(string, "40m")
    delete = optional(string, "80m")
    update = optional(string, "40m")
  })
  default = {}
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}