output "bastion_public_ip" {
  description = "The public IP of the bastion host"
  value       = aws_instance.bastion.public_ip
}

output "bastion_ssh_key_path" {
  description = "The local path of the SSH private key for the bastion host"
  value       = local_file.bastion_private_key.filename
}