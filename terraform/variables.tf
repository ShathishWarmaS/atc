# terraform/variables.tf

variable "aws_region" {
  description = "AWS region where resources will be deployed."
  type        = string
  default     = "us-east-1" # Optional: Set a default value
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16" # Optional: Set a default value
}
variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "atc-app"
}
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

#bastion
# variables.tf in the root directory



variable "vpc_id" {
  description = "ID of the existing VPC for the bastion host"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the existing public subnet for the bastion host"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the bastion server"
  type        = string
  default     = "ami-005fc0f236362e99f"  # Provided AMI ID
}

variable "instance_type" {
  description = "Instance type for the bastion server"
  type        = string
  default     = "t2.micro"
}

variable "allowed_ip" {
  description = "CIDR block for allowed IP for SSH access"
  type        = string
  default     = "YOUR_IP/32"  # Replace with your actual public IP address
}