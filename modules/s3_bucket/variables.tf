variable "s3_bucket_name" {
  description = "Name of the S3 bucket (must be globally unique)"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "enable_versioning" {
  description = "Enable versioning on the bucket (true = Enabled, false = Suspended)"
  type        = bool
  default     = true
}

variable "s3_block_public_acls" {
  description = "Whether to block public ACLs"
  type        = bool
  default     = true
}

variable "s3_block_public_policy" {
  description = "Whether to block public bucket policies"
  type        = bool
  default     = true
}

variable "s3_ignore_public_acls" {
  description = "Whether to ignore public ACLs"
  type        = bool
  default     = true
}

variable "s3_restrict_public_buckets" {
  description = "Whether to restrict public bucket access"
  type        = bool
  default     = true
}

variable "s3_kms_master_key_id" {
  description = "KMS key ARN for server-side encryption (leave empty to use AWS-managed key)"
  type        = string
  default     = ""
}

variable "s3_bucket_policy_file" {
  description = "Path to JSON file containing bucket policy (optional)"
  type        = string
  default     = null
}

variable "s3_lifecycle_config_file" {
  description = "Path to JSON file containing lifecycle rules configuration (optional)"
  type        = string
  default     = null
}