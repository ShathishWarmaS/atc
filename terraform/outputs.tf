# outputs.tf

output "vpc_id" {
  description = "The ID of the ATC App VPC"
  value       = aws_vpc.atc_app_vpc.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private_subnet[*].id
}
#bastion
# outputs.tf in the root directory

output "bastion_public_ip" {
  description = "The public IP of the bastion host"
  value       = module.bastion.bastion_public_ip
}

output "bastion_ssh_key_path" {
  description = "The local path of the SSH private key for the bastion host"
  value       = module.bastion.bastion_ssh_key_path
}


output "kubeconfig_path" {
  value       = local_file.kubeconfig.filename
  description = "Path to the kubeconfig file for the EKS cluster"
}
# Root outputs.tf

output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks_cluster.cluster_name
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = data.aws_eks_cluster.cluster.endpoint
}

output "eks_cluster_ca_certificate" {
  description = "The CA certificate data for the EKS cluster"
  value       = data.aws_eks_cluster.cluster.certificate_authority[0].data
}

output "eks_oidc_url" {
  description = "The OIDC issuer URL for the EKS cluster"
  value       = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}