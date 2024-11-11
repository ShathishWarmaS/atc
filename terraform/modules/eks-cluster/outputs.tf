# modules/eks-cluster/outputs.tf

# EKS Cluster Name
output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.this[0].name
}

# EKS Cluster Endpoint
output "cluster_endpoint" {
  description = "The endpoint for the EKS Kubernetes API"
  value       = aws_eks_cluster.this[0].endpoint
}

# EKS Cluster Certificate Authority Data
output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.this[0].certificate_authority[0].data
}

# EKS Cluster IAM Role ARN
output "eks_cluster_role_arn" {
  description = "The ARN of the EKS cluster IAM role"
  value       = aws_iam_role.eks_cluster_role.arn
}

# Node Group IAM Role ARN (for managed node groups)
output "node_role_arn" {
  description = "The ARN of the IAM role for the EKS node group"
  value       = aws_iam_role.node_group_role.arn
}

# Node Group IAM Role Name (for managed node groups)
output "node_role_name" {
  description = "The name of the IAM role for the EKS node group"
  value       = aws_iam_role.node_group_role.name
}

# VPC ID
output "vpc_id" {
  description = "The VPC ID used by the EKS cluster"
  value       = var.vpc_id
}
