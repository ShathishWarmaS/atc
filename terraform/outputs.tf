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