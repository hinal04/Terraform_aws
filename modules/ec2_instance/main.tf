# Defining the EC2 instance resource
resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = var.subnet_id
  associate_public_ip_address = var.associate_public_ip

  # Optional user data for instance initialization
  user_data = var.user_data != "" ? var.user_data : null

  # Tagging the instance for identification
  tags = merge(
    {
      Name = var.instance_name
    },
    var.additional_tags
  )

  # Ensuring the instance is launched in the specified availability zone
  availability_zone = var.availability_zone
}

