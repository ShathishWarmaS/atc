# terraform.tfvars
aws_region          = "us-east-1"
project_name        = "atc-app"
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
# terraform.tfvars
# bastion
vpc_id           = "vpc-096f081d670b7e36d"  # Replace with your atc-app VPC ID
public_subnet_id = "subnet-06e8a8db4b8aee883"  # Replace with your atc-app public subnet ID
allowed_ip       = "203.0.113.1/32"  # Replace with your public IP
ami_id           = "ami-005fc0f236362e99f"  # Provided AMI for the bastion host
instance_type    = "t2.micro" 