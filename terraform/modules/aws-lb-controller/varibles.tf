variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "aws_region" {
  description = "AWS region where the EKS cluster is deployed"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID associated with the EKS cluster"
  type        = string
}

variable "cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  type        = string
}

variable "cluster_auth_token" {
  description = "The authentication token for the EKS cluster"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "The certificate authority data for the EKS cluster"
  type        = string
}