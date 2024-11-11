# terraform.tfvars
aws_region          = "us-east-1"
project_name        = "atc-app"
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
# terraform.tfvars
# bastion
vpc_id           = "vpc-022c74d1b4d17eca8"  # Replace with your atc-app VPC ID
public_subnet_id = "subnet-0b20d42a997354cce"  # Replace with your atc-app public subnet ID
allowed_ip       = "0.0.0.0/32"  # Replace with your public IP
ami_id           = "ami-005fc0f236362e99f"  # Provided AMI for the bastion host
instance_type    = "t2.micro" 
private_subnet_ids = ["subnet-0dfb767e14a6ac9fc", "subnet-0f46029915fb1431e"]  # Replace with actual subnet IDs
domain_name     = "atccapp.shavini.xyz"  # Your existing Route 53 hosted zone ID
node_disk_size   = 30
node_volume_type = "gp3"
cluster_name = "atcapp"  # Replace with your desired cluster name

cluster_endpoint                 = "https://oidc.eks.us-east-1.amazonaws.com/id/D9F71E82BDE5E34F58442B792A4EDCC2"
cluster_certificate_authority_data = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJRStNOFAzRDdGSGt3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRFeE1UQXhOVEUyTlRkYUZ3MHpOREV4TURneE5USXhOVGRhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUURxSi8vdFl5WU83dUJrRGsvSWJ5a0JOVFcxQ0pBUzNSSWFiM2tRM2NpZUxDbjdyZEZoK2haSmdpMlcKVWZ4WkpGb0wrZWI2bkh4SXJ0MjJvRjgwMWIrbmhIUFdaUi9Wbi9Ibk9MTVJ2OGRKNjN3OXJGNkZidzBUc3ZmdgpFR3dIcGpiMlg3N3dDbTNEUjh2S0NhUlJCVi8rdzdFSWpIdStwK1JPZU9FZzhSMytGM3paUDJFbm1GVHZFeTBjCmMwdHVmNDVwa3kvV0h4SFlJc1E5TkQ0MUIzUEcxM2JpLzR6eDdkcW92cFVwWm54eEp1V09oejdHNExiZkJzMW8KUlJLTUp3ZVRUbjJNWExReUNWNG9WNis2ZWhWanBxbHUvN0JycmE5MmxZbUNuQ3laL1NTWEdHMG9yL29PNWJscwpXRXp5REdZRWxOTklLbTVIdXZYb2dKckNzT3REQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJScVVuTllObFFUVm85TmtSZGY4TDBINE9vb1dqQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQjZ0WisydlhESApWR1BnQTZJNFFpektRZmJ1cFVHcllkZDFkRUVsNWs2NXc2VGh1Wlg5L1VNL1V1L0gxekIvQWU0cEszUHBVelkrClRPNFBBei9DQ1pQM3d4VUtnZ2Z0VXZDZklJNUo3VmFwTWNmV1k3MGVJRzRhajd4NExBSVZDUjhoR0cvcEQvYkYKd2FLVGFSR2ttOW1tcmd5UUdPNmNJNzI0cXJrYTFPZ3AvdmNrMUhFWkpaK0JNcEdPMGZVUGRESEdTM0M2bFRLdQpLU0F6cVFhUTZGbkR6ZUsxN0NHa0djdEEyZDl0NUtsblFoRWhBY2h6eWpnaHA1M2E0cUVRSUcxam9EMXl3VjUzClhOWW5Za1pLNkkxRmJLaHNWK014MHNlL1MxaGZ1Wi9vOTFRdytkWnV0R2hNRGpYVTY0MHZzejYybm9zVjc5aXoKU21PMHNJb1kwR3F1Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"