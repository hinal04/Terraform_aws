output "bucket_id" {
  description = "The name of the bucket"
  value       = aws_s3_bucket.s3_bucket.id
}

output "bucket_arn" {
  description = "The ARN of the bucket"
  value       = aws_s3_bucket.s3_bucket.arn
}

output "bucket_domain_name" {
  description = "The bucket domain name (e.g., bucket.s3.amazonaws.com)"
  value       = aws_s3_bucket.s3_bucket.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "The bucket region-specific domain name"
  value       = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
}

output "bucket_region" {
  description = "The AWS region this bucket resides in"
  value       = aws_s3_bucket.s3_bucket.region
}

output "versioning_status" {
  description = "Current versioning status (Enabled or Suspended)"
  value       = aws_s3_bucket_versioning.s3_bucket_versioning.versioning_configuration[0].status
}

output "bucket_policy_attached" {
  description = "Whether a custom bucket policy was attached"
  value       = length(aws_s3_bucket_policy.s3_bucket_policy) > 0
}

output "lifecycle_configuration_applied" {
  description = "Whether lifecycle rules were applied"
  value       = length(aws_s3_bucket_lifecycle_configuration.bucket_lifecycle) > 0
}