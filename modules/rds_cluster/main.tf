# main.tf

data "aws_ssm_parameter" "sre_parameter_store" {
  name = "/terraform/test/network_config"
}

##############################
# RDS Cluster Subnet Group
##############################
resource "aws_db_subnet_group" "rds_cluster_subnet_group" {
  name       = var.cluster_subnet_group_name
  subnet_ids = var.subnet_ids
}

##############################
# RDS Cluster Parameter Group
##############################
resource "aws_db_parameter_group" "rds_cluster_param_group" {
  name   = var.rds_cluster_param_group_name
  family = var.rds_cluster_param_group_family

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
# Create RDS Cluster (Aurora)
##############################
resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier      = var.cluster_identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  master_username         = jsondecode(nonsensitive(data.aws_ssm_parameter.sre_parameter_store.value))["docdb_username"]
  master_password         = jsondecode(nonsensitive(data.aws_ssm_parameter.sre_parameter_store.value))["docdb_password"]
  storage_encrypted       = true
  availability_zones      = var.availability_zones
  db_subnet_group_name    = aws_db_subnet_group.rds_cluster_subnet_group.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  skip_final_snapshot     = var.skip_final_snapshot
  preferred_backup_window = var.preferred_backup_window
  backup_retention_period = var.backup_retention_period
  preferred_maintenance_window = var.preferred_maintenance_window

  storage_type = "gp3"  # Aurora uses shared, automatically scaling storage

  tags = var.tags
}

##############################
# Add Cluster Instances
##############################
resource "aws_rds_cluster_instance" "rds_cluster_instance" {
  count              = var.number_of_instances_in_the_cluster
  identifier         = "${var.identifier}-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.rds_cluster.id
  engine             = var.engine
  instance_class     = var.instance_class  # Adjust based on your needs
  publicly_accessible = var.publicly_accessible

  db_subnet_group_name    = aws_db_subnet_group.rds_cluster_subnet_group.name
  db_parameter_group_name = aws_db_parameter_group.rds_cluster_param_group.name

  tags = var.tags
}