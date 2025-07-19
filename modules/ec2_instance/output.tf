# Defining the output for the instance ID
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.ec2_instance.id
}

# Defining the output for the instance public IP
output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.ec2_instance.public_ip
}