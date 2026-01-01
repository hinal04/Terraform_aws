# main.tf

##############################
# S3 Bucket
##############################
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket_name
  tags   = var.tags
}

##############################
# Bucket Versioning
##############################
resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

##############################
# Public Access Block
##############################
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = var.s3_block_public_acls
  block_public_policy     = var.s3_block_public_policy
  ignore_public_acls      = var.s3_ignore_public_acls
  restrict_public_buckets = var.s3_restrict_public_buckets
}

##############################
# Server-Side Encryption
##############################
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_encryption" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = var.s3_kms_master_key_id != "" ? var.s3_kms_master_key_id : null
    }
  }
}

##############################
# Bucket Policy (optional)
##############################
locals {
  bucket_policy = var.s3_bucket_policy_file != null && var.s3_bucket_policy_file != "" ? file(var.s3_bucket_policy_file) : null
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  count  = local.bucket_policy != null ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id
  policy = local.bucket_policy
}

##############################
# Lifecycle Configuration (optional)
##############################
locals {
  lifecycle_rules = var.s3_lifecycle_config_file != null && var.s3_lifecycle_config_file != "" ? jsondecode(file(var.s3_lifecycle_config_file)) : []
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
  count  = length(local.lifecycle_rules) > 0 ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id

  dynamic "rule" {
    for_each = local.lifecycle_rules
    content {
      id     = lookup(rule.value, "id", null)
      status = lookup(rule.value, "status", "Enabled")

      filter {
        prefix = lookup(rule.value, "prefix", null)
      }

      dynamic "transition" {
        for_each = lookup(rule.value, "transitions", [])
        content {
          days          = lookup(transition.value, "days", null)
          storage_class = lookup(transition.value, "storage_class", null)
        }
      }

      dynamic "expiration" {
        for_each = lookup(rule.value, "expiration", null) != null ? [rule.value.expiration] : []
        content {
          days = lookup(expiration.value, "days", null)
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = lookup(rule.value, "noncurrent_version_expiration", null) != null ? [rule.value.noncurrent_version_expiration] : []
        content {
          noncurrent_days = lookup(noncurrent_version_expiration.value, "noncurrent_days", null)
        }
      }

      dynamic "abort_incomplete_multipart_upload" {
        for_each = lookup(rule.value, "abort_incomplete_multipart_upload", null) != null ? [rule.value.abort_incomplete_multipart_upload] : []
        content {
          days_after_initiation = lookup(abort_incomplete_multipart_upload.value, "days_after_initiation", null)
        }
      }
    }
  }
}