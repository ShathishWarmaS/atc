# terraform/backend.tf

terraform {
  backend "s3" {
    bucket         = "atctfstate"     # S3 bucket name
    key            = "atc/env/dev/terraform.tfstate"    #  desired state file path
    region         = "us-east-1"                    # AWS region where the S3 bucket is located
    dynamodb_table = "terraform-lock-table"         # your DynamoDB table name
    encrypt        = true                           # Enable encryption for state file
  }
}