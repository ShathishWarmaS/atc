# terraform/variables.tf

variable "aws_region" {
  description = "AWS region where resources will be deployed."
  type        = string
  default     = "us-east-1" # Optional: Set a default value
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16" # Optional: Set a default value
}