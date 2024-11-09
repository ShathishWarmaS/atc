variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "vpc_id" {
  description = "ID of the existing VPC for the bastion host"
  type        = string
}

variable "subnet_id" {
  description = "ID of the existing public subnet for the bastion host"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the bastion server (Ubuntu 22.04)"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the bastion server"
  type        = string
  default     = "t2.micro"  # Default to t2.micro, but it can be overridden
}

variable "allowed_ip" {
  description = "CIDR block for allowed IP for SSH access"
  type        = string
}