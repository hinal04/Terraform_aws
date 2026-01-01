# main.tf

##############################
# DocumentDB Subnet Group
##############################
resource "aws_docdb_subnet_group" "docdb_subnetgroup" {
  name       = var.docdb_subnetgroup_name
  subnet_ids = var.subnet_ids  # Replace with your subnet IDs
  tags       = var.tags
}

##############################
# DocumentDB Cluster Parameter Group
##############################
resource "aws_docdb_cluster_parameter_group" "docdb_parametergroup" {
  name   = var.docdb_parameter_group_name
  family = var.docdb_cluster_family

  dynamic "parameter" {
    for_each = jsondecode(file(var.parameters_file))["parameters"]
    content {
      name  = parameter.value["name"]
      value = parameter.value["value"]
    }
  }

  tags = var.tags
}

##############################
# DocumentDB Cluster
##############################
resource "aws_docdb_cluster" "docdb_cluster" {
  cluster_identifier      = var.cluster_identifier_name
  master_username         = var.master_username
  master_password         = var.master_password
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  vpc_security_group_ids  = var.vpc_security_group_ids
  storage_encrypted       = var.storage_encrypted
  db_subnet_group_name    = aws_docdb_subnet_group.docdb_subnetgroup.name
  skip_final_snapshot     = var.skip_final_snapshot
  tags                    = var.tags
}

##############################
# DocumentDB Cluster Instances
##############################
resource "aws_docdb_cluster_instance" "docdb_instance" {
  count              = var.number_of_instances
  identifier         = "${var.cluster_identifier_name}-${count.index + 1}"
  cluster_identifier = aws_docdb_cluster.docdb_cluster.id
  instance_class     = var.instance_class
  apply_immediately  = var.apply_immediately

  tags = var.tags
}