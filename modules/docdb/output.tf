output "docdb_subnet_group_name" {
  description = "Name of the created DocumentDB subnet group"
  value       = aws_docdb_subnet_group.docdb_subnetgroup.name
}

output "docdb_cluster_parameter_group_name" {
  description = "Name of the created DocumentDB cluster parameter group"
  value       = aws_docdb_cluster_parameter_group.docdb_parametergroup.name
}

output "docdb_cluster_id" {
  description = "The DocumentDB cluster identifier"
  value       = aws_docdb_cluster.docdb_cluster.id
}

output "docdb_cluster_arn" {
  description = "The ARN of the DocumentDB cluster"
  value       = aws_docdb_cluster.docdb_cluster.arn
}

output "docdb_cluster_endpoint" {
  description = "Writer endpoint for the DocumentDB cluster"
  value       = aws_docdb_cluster.docdb_cluster.endpoint
}

output "docdb_cluster_reader_endpoint" {
  description = "Reader endpoint for the DocumentDB cluster"
  value       = aws_docdb_cluster.docdb_cluster.reader_endpoint
}

output "docdb_cluster_port" {
  description = "The port on which the DocumentDB cluster accepts connections"
  value       = aws_docdb_cluster.docdb_cluster.port
}

output "docdb_instance_ids" {
  description = "List of DocumentDB instance identifiers"
  value       = aws_docdb_cluster_instance.docdb_instance[*].id
}

output "docdb_instance_endpoints" {
  description = "List of individual instance endpoints"
  value       = aws_docdb_cluster_instance.docdb_instance[*].endpoint
}

output "docdb_cluster_resource_id" {
  description = "The DocumentDB Cluster Resource ID"
  value       = aws_docdb_cluster.docdb_cluster.cluster_resource_id
}