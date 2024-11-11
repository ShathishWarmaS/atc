# AWS Region
variable "aws_region" {
  description = "AWS region where resources will be deployed."
  type        = string
  default     = "us-east-1" # Optional: Set a default value
}

# VPC and Subnet Configuration
variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
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

# Bastion Host Variables
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
  default     = "ami-005fc0f236362e99f"
}

variable "instance_type" {
  description = "Instance type for the bastion server"
  type        = string
  default     = "t2.micro"
}

variable "allowed_ip" {
  description = "CIDR block for allowed IP for SSH access"
  type        = string
  default     = "0.0.0.0/0"  # Example; replace with specific IP or use a variable
}

# EKS Cluster Variables
variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "k8s_version" {
  type        = string
  description = "Kubernetes version for EKS"
  default     = "1.30"
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Desired number of nodes in the node group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of nodes in the node group"
  type        = number
  default     = 5
}

variable "min_size" {
  description = "Minimum number of nodes in the node group"
  type        = number
  default     = 1
}

variable "max_unavailable" {
  description = "Maximum number of nodes unavailable during update"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

# IRSA Configuration
variable "irsa_namespace" {
  type        = string
  description = "Namespace for the IRSA-enabled service account"
}

variable "irsa_service_account" {
  type        = string
  description = "Service account name for IRSA"
}

variable "irsa_policy_arn" {
  type        = string
  description = "ARN of IAM policy to attach to the IRSA role"
}

# Domain and SSL Configuration
variable "domain_name" {
  description = "The domain name for the application"
  type        = string
}

variable "letsencrypt_email" {
  description = "Email address for Let's Encrypt notifications"
  type        = string
}

# EKS Node Group Disk Configuration
variable "node_disk_size" {
  description = "Disk size for EKS node group instances"
  type        = number
  default     = 30
}

variable "node_volume_type" {
  description = "EBS volume type for EKS node group instances"
  type        = string
  default     = "gp3"
}

# EKS Cluster Outputs for External Use
variable "cluster_endpoint" {
  description = "The endpoint for the EKS Kubernetes API"
  type        = string
}

variable "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the EKS cluster"
  type        = string
}