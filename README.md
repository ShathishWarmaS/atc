# atc Task Assignment
	•	Frontend: A static web application served by Nginx.
	•	Backend: A Flask API.
	•	Autoscaling: Both Node Autoscaling and Horizontal Pod Autoscaling (HPA).
	•	Monitoring: Prometheus for monitoring metrics.


Terraform apply 
Outputs:

private_subnet_ids = [
  "subnet-0f5c2f636a9f1a799",
  "subnet-02d2d88fcb464e2db",
]
public_subnet_ids = [
  "subnet-06e8a8db4b8aee883",
  "subnet-0cfbdc64721c44f24",
]
vpc_id = "vpc-096f081d670b7e36d"


bastion

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

Outputs:

bastion_public_ip = "54.83.180.84"
bastion_ssh_key_path = "modules/bastion/bastion_key.pem"
private_subnet_ids = [
  "subnet-0f5c2f636a9f1a799",
  "subnet-02d2d88fcb464e2db",
]
public_subnet_ids = [
  "subnet-06e8a8db4b8aee883",
  "subnet-0cfbdc64721c44f24",
]
vpc_id = "vpc-096f081d670b7e36d"