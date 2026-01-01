output "rds_cluster_id" {
  description = "The ID of the RDS cluster"
  value       = aws_rds_cluster.rds_cluster.id
}

output "rds_cluster_arn" {
  description = "The ARN of the RDS cluster"
  value       = aws_rds_cluster.rds_cluster.arn
}

output "rds_cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = aws_rds_cluster.rds_cluster.endpoint
}

output "rds_cluster_reader_endpoint" {
  description = "Reader endpoint for the cluster (load-balanced across readers)"
  value       = aws_rds_cluster.rds_cluster.reader_endpoint
}

output "rds_cluster_port" {
  description = "The database port"
  value       = aws_rds_cluster.rds_cluster.port
}

output "rds_cluster_resource_id" {
  description = "The RDS Cluster Resource ID"
  value       = aws_rds_cluster.rds_cluster.cluster_resource_id
}

output "cluster_instance_ids" {
  description = "List of instance identifiers in the cluster"
  value       = aws_rds_cluster_instance.rds_cluster_instance[*].id
}

output "cluster_instance_endpoints" {
  description = "List of individual instance endpoints"
  value       = aws_rds_cluster_instance.rds_cluster_instance[*].endpoint
}

output "db_subnet_group_name" {
  description = "Name of the created DB subnet group"
  value       = aws_db_subnet_group.rds_cluster_subnet_group.name
}

output "db_cluster_parameter_group_name" {
  description = "Name of the created DB cluster parameter group"
  value       = aws_db_parameter_group.rds_cluster_param_group.name
}