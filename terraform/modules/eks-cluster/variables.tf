# modules/eks-cluster/variables.tf

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "k8s_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.30"
}

variable "vpc_id" {
  description = "ID of the VPC for the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}
# Declare these in variables.tf or main.tf

variable "cluster_endpoint" {
  description = "The endpoint URL for the EKS Kubernetes API"
  type        = string
}

variable "cluster_certificate_authority_data" {
  description = "The base64-encoded certificate data for the EKS cluster"
  type        = string
}