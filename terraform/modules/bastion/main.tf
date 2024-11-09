# modules/bastion/main.tf

# Security group for bastion host within the specified VPC
resource "aws_security_group" "bastion_sg" {
  name_prefix = "${var.project_name}-bastion-sg"
  description = "Security group for bastion host"
  vpc_id      = var.vpc_id  # Reference the provided VPC

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip]  # Allow SSH from specified IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Generate a new SSH key pair
resource "tls_private_key" "bastion_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create the key pair in AWS using the generated public key
resource "aws_key_pair" "bastion_key" {
  key_name   = "${var.project_name}-bastion-key"
  public_key = tls_private_key.bastion_key.public_key_openssh
}

# Save the private key locally
resource "local_file" "bastion_private_key" {
  content  = tls_private_key.bastion_key.private_key_pem
  filename = "${path.module}/bastion_key.pem"
  # Set file permissions to secure the key
  file_permission = "0400"
}

# EC2 instance for the bastion host within the provided subnet
resource "aws_instance" "bastion" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id  # Reference the provided subnet
  key_name      = aws_key_pair.bastion_key.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]  # Use the security group ID

  # Install AWS CLI, kubectl, and other utilities on Ubuntu 22.04 using user_data
  user_data = <<-EOF
    #!/bin/bash
    # Update package list and install necessary dependencies
    apt-get update -y
    apt-get install -y curl unzip apt-transport-https gnupg software-properties-common

    # Install AWS CLI
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf awscliv2.zip ./aws

    # Install kubectl
    curl -fsSL -o /usr/local/bin/kubectl https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x /usr/local/bin/kubectl

    # Install jq for JSON parsing
    apt-get install -y jq

    # Install Helm (for managing Kubernetes packages)
    curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null
    apt-get install -y apt-transport-https
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
    apt-get update -y
    apt-get install -y helm

    # Install Terraform (if needed)
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
    apt-get update -y
    apt-get install -y terraform

    # Verify installations
    aws --version
    kubectl version --client
    jq --version
    helm version
    terraform -version
  EOF

  tags = {
    Name = "${var.project_name}-bastion"
  }
}