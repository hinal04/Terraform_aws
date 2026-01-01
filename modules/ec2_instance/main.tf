workspace "terraform" {
  module "ec2_instance" {
    source = "./ec2_instance"
  }
}

resource "aws_instance" "ec2_instance" {
  count                = var.num_instance
  ami                  = var.ami
  instance_type        = var.instance_type
  key_name             = var.key_name
  monitoring           = var.monitoring
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id            = var.subnet_id
  iam_instance_profile = var.iam_instance_profile
  associate_public_ip_address = var.associate_public_ip_address
  ebs_optimized        = var.ebs_optimized

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = try(root_block_device.value.delete_on_termination, null)
      encrypted             = try(root_block_device.value.encrypted, null)
      iops                  = try(root_block_device.value.iops, null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = try(root_block_device.value.volume_size, null)
      volume_type           = try(root_block_device.value.volume_type, null)
      throughput            = try(root_block_device.value.throughput, null)
      tags                  = try(root_block_device.value.tags, null)
    }
  }

  user_data = <<EOF
#!/bin/bash
echo "Hello, Hinal here"
EOF

  tags = merge(
    {
      Name = "${var.instance_name}-${count.index + 1}"
    },
    var.tags
  )
}