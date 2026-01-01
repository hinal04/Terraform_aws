output "rds_subnet_group_name" {
  description = "The name of the created RDS subnet group"
  value       = aws_db_subnet_group.rds_subnet_group.name
}

output "rds_subnet_group_id" {
  description = "The ID of the created RDS subnet group"
  value       = aws_db_subnet_group.rds_subnet_group.id
}

output "rds_parameter_group_name" {
  description = "The name of the created parameter group"
  value       = aws_db_parameter_group.rds_param_group.name
}

output "rds_parameter_group_id" {
  description = "The ID of the created parameter group"
  value       = aws_db_parameter_group.rds_param_group.id
}

output "db_instance_id" {
  description = "The RDS instance identifier"
  value       = aws_db_instance.rds_db.id
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.rds_db.arn
}

output "db_instance_endpoint" {
  description = "The connection endpoint (host:port)"
  value       = aws_db_instance.rds_db.endpoint
}

output "db_instance_address" {
  description = "The hostname of the RDS instance"
  value       = aws_db_instance.rds_db.address
}

output "db_instance_port" {
  description = "The database port"
  value       = aws_db_instance.rds_db.port
}

output "db_instance_username" {
  description = "The master username"
  value       = aws_db_instance.rds_db.username
  sensitive   = true
}

output "db_name" {
  description = "The initial database name"
  value       = aws_db_instance.rds_db.db_name
}