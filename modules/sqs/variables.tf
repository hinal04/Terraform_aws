variable "queue_count" {
  description = "Number of SQS queues to create"
  type        = number
  default     = 1
}

variable "base_queue_name" {
  description = "Base name for the SQS queue(s). Index will be appended if queue_count > 1"
  type        = string
}

variable "fifo_queue" {
  description = "Whether to create FIFO queues (true) or standard queues (false)"
  type        = bool
  default     = false
}

variable "visibility_timeout" {
  description = "Visibility timeout for the queue in seconds"
  type        = number
  default     = 30
}

variable "retention_seconds" {
  description = "Message retention period in seconds"
  type        = number
  default     = 345600  # 4 days
}

variable "delay_seconds" {
  description = "Delay seconds for the queue"
  type        = number
  default     = 0
}

variable "receive_wait_time" {
  description = "Receive message wait time in seconds (long polling)"
  type        = number
  default     = 0
}

variable "enable_encryption" {
  description = "Whether to enable server-side encryption"
  type        = bool
  default     = true
}

variable "encryption_key_type" {
  description = "Encryption type: 'SSE-SQS' for AWS-managed or 'SSE-KMS' for customer-managed KMS key"
  type        = string
  validation {
    condition     = contains(["SSE-SQS", "SSE-KMS"], var.encryption_key_type)
    error_message = "encryption_key_type must be either 'SSE-SQS' or 'SSE-KMS'."
  }
  default = "SSE-SQS"
}

variable "kms_key_id" {
  description = "KMS key ID or ARN when encryption_key_type is 'SSE-KMS'. Required if SSE-KMS is chosen"
  type        = string
  default     = ""
}

variable "content_based_deduplication" {
  description = "Enable content-based deduplication (only for FIFO queues)"
  type        = bool
  default     = false
}

variable "deduplication_scope" {
  description = "Deduplication scope for FIFO queues: 'queue' or 'messageGroup'"
  type        = string
  default     = null
  validation {
    condition     = var.deduplication_scope == null || contains(["queue", "messageGroup"], var.deduplication_scope)
    error_message = "deduplication_scope must be 'queue' or 'messageGroup'."
  }
}

variable "role_arn_to_attach_sqs_policy" {
  description = "IAM role ARN to attach SendMessage/ReceiveMessage permissions. Leave empty to skip policy creation"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}