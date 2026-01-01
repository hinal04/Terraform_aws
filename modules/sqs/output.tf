output "queue_ids" {
  description = "List of SQS queue IDs"
  value       = aws_sqs_queue.sqs[*].id
}

output "queue_urls" {
  description = "List of SQS queue URLs"
  value       = aws_sqs_queue.sqs[*].url
}

output "queue_arns" {
  description = "List of SQS queue ARNs"
  value       = aws_sqs_queue.sqs[*].arn
}

output "queue_names" {
  description = "List of SQS queue names"
  value       = aws_sqs_queue.sqs[*].name
}

output "queue_policy_attached" {
  description = "Whether the custom SQS policy was attached"
  value       = length(aws_sqs_queue_policy.sqs_policy) > 0
}

output "queue_policy_ids" {
  description = "List of attached SQS policy IDs (empty if not attached)"
  value       = aws_sqs_queue_policy.sqs_policy[*].id
}