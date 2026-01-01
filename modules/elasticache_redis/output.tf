output "id" {
  description = "The ID of the ElastiCache Serverless Cache"
  value       = try(aws_elasticache_serverless_cache.serverless[0].id, null)
}

output "arn" {
  description = "The ARN of the ElastiCache Serverless Cache"
  value       = try(aws_elasticache_serverless_cache.serverless[0].arn, null)
}

output "endpoint" {
  description = "The endpoint address of the serverless cache"
  value       = try(aws_elasticache_serverless_cache.serverless[0].endpoint[0].address, null)
}

output "port" {
  description = "The port number of the serverless cache endpoint"
  value       = try(aws_elasticache_serverless_cache.serverless[0].endpoint[0].port, null)
}

output "reader_endpoint" {
  description = "The reader endpoint address (if available)"
  value       = try(aws_elasticache_serverless_cache.serverless[0].reader_endpoint_address, null)
}

output "status" {
  description = "The current status of the serverless cache"
  value       = try(aws_elasticache_serverless_cache.serverless[0].status, null)
}

output "cache_name" {
  description = "The name of the created serverless cache"
  value       = try(aws_elasticache_serverless_cache.serverless[0].name, null)
}