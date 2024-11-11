# atc Task Assignment
	•	Frontend: A static web application served by Nginx.
	•	Backend: A Flask API.
	•	Autoscaling: Both Node Autoscaling and Horizontal Pod Autoscaling (HPA).
	•	Monitoring: Prometheus for monitoring metrics.

Web Application Deployment on AWS with Kubernetes, Terraform, Docker, and CI/CD

This project automates the infrastructure setup and deployment of a web application on AWS EKS (Elastic Kubernetes Service). The solution uses Terraform for infrastructure provisioning, Docker for containerization, and Prometheus for monitoring. The application is deployed via GitHub Actions CI/CD pipeline, ensuring streamlined deployments.

Table of Contents

	1.	Project Overview
	2.	Architecture
	3.	Pre-requisites
	4.	Infrastructure Setup
	•	1. Initialize Terraform
	•	2. Validate Terraform Configuration
	•	3. Plan and Apply Infrastructure
	5.	Application Deployment in Kubernetes
	6.	Monitoring with Prometheus
	7.	CI/CD Pipeline with GitHub Actions
	8.	File Structure
	9.	Terraform Variables
	10.	Terraform Outputs
	11.	Cleanup
	12.	Additional Notes

  Project Overview

This project automates the provisioning of cloud infrastructure and the deployment of a simple web application. Key components include:
	•	Network Infrastructure: VPC, public and private subnets, NAT Gateways, and routing tables.
	•	Kubernetes (EKS): Elastic Kubernetes Service for container orchestration.
	•	CI/CD Pipeline: GitHub Actions pipeline to build Docker images, push to ECR, and deploy on EKS.
	•	Monitoring: Prometheus for monitoring and AWS Certificate Manager for SSL.
	•	Domain Management: Route 53 for DNS resolution with ACM for SSL.

Architecture

	•	VPC and Subnets: A custom VPC with public and private subnets for network isolation.
	•	EKS Cluster: Kubernetes cluster to deploy containerized applications.
	•	Node Groups: Managed node groups for EKS.
	•	Load Balancer Controller: AWS Load Balancer Controller for ingress management.
	•	Prometheus: Monitoring setup in the Kubernetes cluster.
	•	Bastion Host: Secure access to resources within private subnets.
	•	Route 53 and ACM: Route 53 for domain resolution and ACM for SSL.

Pre-requisites

	1.	Terraform (>= 0.13) installed and configured.
	2.	AWS CLI configured with an IAM user.
	3.	Docker installed for building and managing container images.
	4.	kubectl to manage Kubernetes resources.
	5.	GitHub repository secrets configured for GitHub Actions.

Infrastructure Setup

The project is divided into modules for reusability and modularity. Each module (e.g., bastion, eks-cluster, node-group) has its main.tf, variables.tf, and outputs.tf files.
The project is divided into modules for reusability and modularity. Each module (e.g., bastion, eks-cluster, node-group) has its main.tf, variables.tf, and outputs.tf files.

1. Initialize Terraform

In the root directory, initialize Terraform to download necessary providers and modules.
terraform init
2. Validate Terraform Configuration

Validate the configuration files to catch any syntax or configuration errors.
terraform validate
3. Plan and Apply Infrastructure

Create a plan to visualize the resources Terraform will create, then apply the plan:
terraform plan -var-file="terraform.tfvars" -out root-plan.tfplan
terraform apply "root-plan.tfplan" -auto-approve
Important terraform.tfvars Variables

You can set these values in a terraform.tfvars file for easy configuration. Below is an example configuration:
aws_region           = "us-east-1"
cluster_name         = "webapp-eks-cluster"
project_name         = "webapp"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
domain_name          = "yourdomain.com"
letsencrypt_email    = "admin@yourdomain.com"
Application Deployment in Kubernetes

	1.	Update kubeconfig: Configure kubectl to use the EKS cluster by updating your kubeconfig:
  aws eks update-kubeconfig --name <cluster_name> --region <region>
  	2.	Deploy Applications: Apply the deployment files in the k8s/ directory.
    kubectl apply -f k8s/
  	3.	Verify Deployment: Check that the pods and services are running:
    kubectl get pods,svc -n <namespace>
  
  Monitoring with Prometheus

	1.	Install Prometheus: Install Prometheus using Helm in the Kubernetes cluster.
  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  helm install prometheus prometheus-community/prometheus
  	2.	Access Prometheus: Set up an ingress to access Prometheus or use port-forwarding for local access.
    kubectl port-forward service/prometheus-server 9090:80
    CI/CD Pipeline with GitHub Actions

The project uses GitHub Actions to automate building Docker images, pushing to ECR, and deploying to EKS. The GitHub Actions workflow .github/workflows/deploy.yml handles this automation.

GitHub Secrets

You will need to set up GitHub secrets for this CI/CD pipeline to work:
Secret	Description
AWS_ACCESS_KEY_ID	AWS Access Key ID
AWS_SECRET_ACCESS_KEY	AWS Secret Access Key
AWS_REGION	AWS region (e.g., us-east-1)
CLUSTER_NAME	Name of the EKS cluster
ECR_REPO_FRONTEND	ECR repository URL for the frontend image
ECR_REPO_BACKEND	ECR repository URL for the backend image
GitHub Actions Workflow Steps

	1.	Login to ECR: Log in to ECR to push Docker images.
	2.	Build Docker Images: Build and tag Docker images for frontend and backend.
	3.	Push to ECR: Push the images to ECR.
	4.	Deploy to EKS: Update the Kubernetes manifests with the latest image tags and apply them to the EKS cluster.

File Structure

.
├── main.tf                    # Root Terraform configuration for VPC, EKS, etc.
├── variables.tf               # Variable definitions
├── terraform.tfvars           # Variable values for deployment
├── outputs.tf                 # Outputs of the Terraform deployment
├── modules/
│   ├── bastion/               # Bastion host setup module
│   ├── eks-cluster/           # EKS cluster setup module
│   ├── aws-lb-controller/     # AWS LB Controller for ingress
│   └── node-group/            # Node group setup for EKS
└── k8s/
    ├── frontend-deployment.yaml # Kubernetes deployment for frontend
    ├── backend-deployment.yaml  # Kubernetes deployment for backend
    ├── prometheus-config.yaml   # Configurations for Prometheus monitoring
    └── ingress.yaml             # Ingress configuration with Route 53 and ACM


    Terraform Variables

The following are essential variables used in the variables.tf file:
	•	aws_region: AWS region for deployment.
	•	cluster_name: EKS cluster name.
	•	public_subnet_cidrs / private_subnet_cidrs: CIDR blocks for subnets.
	•	domain_name: Domain for Route 53 DNS.
	•	letsencrypt_email: Email for Let’s Encrypt SSL certificate.

Terraform Outputs

Key outputs in outputs.tf:
	•	cluster_endpoint: URL for the Kubernetes API endpoint.
	•	node_role_arn: ARN of the IAM role for EKS node groups.
	•	bastion_ip: Public IP for the bastion host for secure access.

Cleanup

To destroy all created infrastructure and prevent charges:
terraform destroy -var-file="terraform.tfvars" -auto-approve
Ensure all Kubernetes resources are deleted before this step to prevent persistent resources and costs.

Additional Notes

	•	Bastion Host: Provides SSH access to private subnet resources. Configure SSH access through a security group.
	•	DNS and SSL: Route 53 handles DNS, and ACM issues SSL certificates for secure HTTP access.
	•	Load Balancer Controller: Configured to handle ingress and routing for the EKS cluster.
	•	Auto-scaling: Node group parameters like desired_capacity, max_size, and min_size control scalability.
	•	Monitoring: Prometheus is configured to scrape metrics from the Kubernetes environment.