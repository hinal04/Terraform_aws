# main.tf

##############################
# Create RDS Subnet Group
##############################
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.subnet_group_name
  subnet_ids = var.rds_subnets
  tags       = var.tags
}

##############################
# Create RDS Parameter Group
##############################
resource "aws_db_parameter_group" "rds_param_group" {
  name   = var.rds_param_group_name
  family = var.rds_param_group_family

  # Example parameter: max_connections
  # value = var.rds_param_max_connection

  dynamic "parameter" {
    for_each = jsondecode(file(var.parameter_file_path))
    content {
      name         = parameter.value["name"]
      value        = parameter.value["value"]
      apply_method = parameter.value["apply_method"]
    }
  }
}

##############################
# Create RDS MySQL Instance
##############################
resource "aws_db_instance" "rds_db" {
  identifier                  = var.db_identifier
  engine                      = var.db_engine
  engine_version              = var.db_engine_version
  instance_class              = var.db_instance_class
  allocated_storage           = var.db_allocated_storage
  max_allocated_storage       = var.db_max_allocated_storage
  storage_type                = var.storage_type
  storage_encrypted           = var.db_username
  username                    = var.db_username
  password                    = var.db_password
  db_name                     = var.db_name
  publicly_accessible         = var.publicly_accessible
  multi_az                    = var.multi_az
  storage_encrypted           = var.storage_encrypted
  skip_final_snapshot         = var.skip_final_snapshot

  vpc_security_group_ids      = var.rds_security_groups
  db_subnet_group_name        = aws_db_subnet_group.rds_subnet_group.name
  parameter_group_name        = aws_db_parameter_group.rds_param_group.name

  # Backup & Maintenance Configuration
  backup_retention_period     = var.backup_retention_period
  backup_window               = var.backup_window
  maintenance_window          = var.maintenance_window

  tags = var.tags
}