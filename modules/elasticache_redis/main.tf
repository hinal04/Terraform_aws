# Defining the ElastiCache subnet group
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name        = "${var.cluster_id}-subnet-group"
  description = "Subnet group for ElastiCache Redis cluster"
  subnet_ids  = var.subnet_ids
}

# Defining the ElastiCache parameter group
resource "aws_elasticache_parameter_group" "redis_parameter_group" {
  name        = "${var.cluster_id}-parameter-group"
  family      = var.redis_family
  description = "Parameter group for ElastiCache Redis cluster"

  dynamic "parameter" {
    for_each = var.redis_parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }
}

# Defining the security group for the Redis cluster
resource "aws_security_group" "redis_sg" {
  name        = "${var.cluster_id}-sg"
  description = "Security group for ElastiCache Redis cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "${var.cluster_id}-sg"
    },
    var.additional_tags
  )
}

# Defining the ElastiCache Redis replication group
resource "aws_elasticache_replication_group" "redis_cluster" {
  replication_group_id          = var.cluster_id
  description                   = "Redis cluster for ${var.cluster_id}"
  engine                        = "redis"
  engine_version                = var.engine_version
  node_type                     = var.node_type
  num_cache_clusters            = var.num_cache_nodes
  port                          = var.port
  parameter_group_name           = aws_elasticache_parameter_group.redis_parameter_group.name
  subnet_group_name             = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids            = [aws_security_group.redis_sg.id]
  automatic_failover_enabled    = var.automatic_failover_enabled
  multi_az_enabled              = var.multi_az_enabled
  at_rest_encryption_enabled    = var.at_rest_encryption_enabled
  transit_encryption_enabled    = var.transit_encryption_enabled
  auth_token                    = var.transit_encryption_enabled ? var.auth_token : null