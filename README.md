# atc Task Assignment
	•	Frontend: A static web application served by Nginx.
	•	Backend: A Flask API.
	•	Autoscaling: Both Node Autoscaling and Horizontal Pod Autoscaling (HPA).
	•	Monitoring: Prometheus for monitoring metrics.

 ## Project Structure
 my-app/
├── infrastructure/
│   ├── main.tf                  # Main Terraform configuration for AWS EKS
│   ├── variables.tf             # Input variables for Terraform
│   ├── outputs.tf               # Outputs from Terraform
│   ├── iam_policies.tf          # IAM roles and policies for EKS and Cluster Autoscaler
│   ├── cluster_autoscaler.yaml   # Cluster Autoscaler deployment configuration
├── frontend/
│   ├── Dockerfile                # Dockerfile for the static web app
│   ├── index.html                # Static HTML file for the app
│   └── k8s/
│       ├── deployment.yaml       # Kubernetes Deployment for the frontend
│       ├── service.yaml          # Kubernetes Service for the frontend
│       └── hpa.yaml              # HPA configuration for the frontend
├── backend/
│   ├── Dockerfile                # Dockerfile for the Flask backend API
│   ├── app.py                    # Flask application code
│   └── k8s/
│       ├── deployment.yaml       # Kubernetes Deployment for the backend
│       ├── service.yaml          # Kubernetes Service for the backend
│       └── hpa.yaml              # HPA configuration for the backend
├── monitoring/
│   ├── prometheus-config.yaml    # Prometheus configuration
│   └── prometheus-deployment.yaml # Prometheus deployment configuration
└── README.md                    # Deployment instructions
