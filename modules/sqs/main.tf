# main.tf

##############################
# SQS Queue (Standard or FIFO)
##############################
resource "aws_sqs_queue" "sqs" {
  count = var.queue_count

  name = "${var.base_queue_name}-${count.index}"

  fifo_queue                      = var.fifo_queue
  visibility_timeout_seconds      = var.visibility_timeout
  message_retention_seconds       = var.retention_seconds
  delay_seconds                   = var.delay_seconds
  receive_wait_time_seconds       = var.receive_wait_time

  # Encryption logic
  sqs_managed_sse_enabled = var.enable_encryption && var.encryption_key_type == "SSE-SQS" ? true : false
  kms_master_key_id       = var.enable_encryption && var.encryption_key_type == "SSE-KMS" ? var.kms_key_id : null

  content_based_deduplication = var.fifo_queue ? var.content_based_deduplication : null
  deduplication_scope         = var.fifo_queue ? var.deduplication_scope : null

  tags = var.tags
}

##############################
# SQS Queue Policy (to allow Send/Receive from a role)
##############################
resource "aws_sqs_queue_policy" "sqs_policy" {
  count = var.role_arn_to_attach_sqs_policy != "" ? var.queue_count : 0

  queue_url = aws_sqs_queue.sqs[count.index].id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "SQSQueuePolicy"
    Statement = [
      {
        Sid       = "AllowSendAndReceiveMessage"
        Effect    = "Allow"
        Principal = {
          AWS = var.role_arn_to_attach_sqs_policy
        }
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage"
        ]
        Resource = aws_sqs_queue.sqs[count.index].arn
      }
    ]
  })
}