output "instance_ids" {
  description = "List of EC2 instance IDs created"
  value       = aws_instance.ec2_instance[*].id
}

output "instance_private_ips" {
  description = "List of private IP addresses assigned to the instances"
  value       = aws_instance.ec2_instance[*].private_ip
}

output "instance_public_ips" {
  description = "List of public IP addresses assigned to the instances (if associate_public_ip_address is true)"
  value       = aws_instance.ec2_instance[*].public_ip
}

output "instance_names" {
  description = "Names of the instances from the Name tag"
  value       = [for instance in aws_instance.ec2_instance : instance.tags["Name"]]
}

output "instance_arns" {
  description = "ARNs of the created EC2 instances"
  value       = aws_instance.ec2_instance[*].arn
}