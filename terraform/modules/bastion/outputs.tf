output "bastion_public_ip" {
  description = "The public IP of the bastion host"
  value       = aws_instance.bastion.public_ip
}

output "bastion_ssh_key_path" {
  description = "The local path of the SSH private key for the bastion host"
  value       = local_file.bastion_private_key.filename
}

# modules/bastion/outputs.tf

output "bastion_key_name" {
  description = "The name of the SSH key pair for the bastion host"
  value       = aws_key_pair.bastion_key.key_name
}

output "bastion_sg_id" {
  description = "The ID of the security group for the bastion host"
  value       = aws_security_group.bastion_sg.id
}