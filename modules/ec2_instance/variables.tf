# Defining variables for the module
variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance (e.g., t2.micro)"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "The name tag for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "The name of the key pair to use for the instance"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
  type        = string
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = true
}

variable "user_data" {
  description = "User data script to initialize the instance"
  type        = string
  default     = ""
}

variable "additional_tags" {
  description = "Additional tags for the EC2 instance"
  type        = map(string)
  default     = {}
}

variable "availability_zone" {
  description = "The availability zone to launch the instance in"
  type        = string
}
