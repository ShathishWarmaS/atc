# main.tf

# Data source to fetch the list of availability zones
data "aws_availability_zones" "available" {}

# Create VPC
resource "aws_vpc" "atc_app_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "atc-app-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "atc_app_igw" {
  vpc_id = aws_vpc.atc_app_vpc.id
  tags = {
    Name = "atc-app-igw"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.atc_app_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "atc-app-public-subnet-${count.index + 1}"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.atc_app_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "atc-app-private-subnet-${count.index + 1}"
  }
}

# NAT Gateway for Private Subnets
resource "aws_eip" "nat_eip" {
  count = length(var.public_subnet_cidrs)
}

resource "aws_nat_gateway" "nat_gw" {
  count         = length(var.public_subnet_cidrs)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id
  tags = {
    Name = "atc-app-nat-gw-${count.index + 1}"
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.atc_app_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.atc_app_igw.id
  }
  tags = {
    Name = "atc-app-public-rt"
  }
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public_rt_assoc" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

# Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.atc_app_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw[0].id
  }
  tags = {
    Name = "atc-app-private-rt"
  }
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private_rt_assoc" {
  count          = length(aws_subnet.private_subnet)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}
# main.tf in the root directory

module "bastion" {
  source             = "./modules/bastion"
  project_name       = var.project_name
  vpc_id             = var.vpc_id
  subnet_id          = var.public_subnet_id
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  allowed_ip         = var.allowed_ip

  # Pass the kubeconfig content generated after the EKS cluster is created
  kubeconfig_content = local_file.kubeconfig.content

  # Set dependency on eks_cluster to ensure EKS is created before remote-exec runs
  depends_on = [module.eks_cluster]
}

# VPC and subnet creation ...

# EKS Cluster Module
module "eks_cluster" {
  source          = "./modules/eks-cluster"
  cluster_name    = var.cluster_name
  k8s_version     = var.k8s_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.private_subnet_ids
}

# Generate Kubeconfig file using outputs from EKS module
resource "local_file" "kubeconfig" {
  content = <<-EOT
    apiVersion: v1
    clusters:
    - cluster:
        server: ${module.eks_cluster.cluster_endpoint}
        certificate-authority-data: ${module.eks_cluster.cluster_certificate_authority_data}
      name: ${module.eks_cluster.cluster_name}
    contexts:
    - context:
        cluster: ${module.eks_cluster.cluster_name}
        user: ${module.eks_cluster.cluster_name}
      name: ${module.eks_cluster.cluster_name}
    current-context: ${module.eks_cluster.cluster_name}
    kind: Config
    preferences: {}
    users:
    - name: ${module.eks_cluster.cluster_name}
      user:
        exec:
          apiVersion: client.authentication.k8s.io/v1alpha1
          command: aws
          args:
            - "eks"
            - "get-token"
            - "--region"
            - "${var.aws_region}"
            - "--cluster-name"
            - "${module.eks_cluster.cluster_name}"
  EOT
  filename = "${path.module}/kubeconfig_${module.eks_cluster.cluster_name}"
}

# Node Group
module "node_group" {
  source           = "./modules/node-group"
  cluster_name     = module.eks_cluster.cluster_name
  node_group_name  = "primary-node-group"
  node_role_arn    = module.eks_cluster.node_role_arn
  subnet_ids       = [for subnet in aws_subnet.private_subnet : subnet.id]
  instance_type    = var.instance_type
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size
  max_unavailable  = var.max_unavailable
  disk_size        = var.node_disk_size
  volume_type      = var.node_volume_type
}
# Helm Provider Configuration
provider "helm" {
  kubernetes {
    host                   = module.eks_cluster.cluster_endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(module.eks_cluster.cluster_certificate_authority_data)
  }
}

# Kubernetes Provider Configuration
provider "kubernetes" {
  host                   = module.eks_cluster.cluster_endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(module.eks_cluster.cluster_certificate_authority_data)
}

resource "aws_iam_policy" "cluster_autoscaler_policy" {
  name   = "${var.cluster_name}-autoscaler-policy"
  path   = "/"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeTags",
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup",
          "autoscaling:UpdateAutoScalingGroup",
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler_role_attach" {
  role       = module.eks_cluster.node_role_name
  policy_arn = aws_iam_policy.cluster_autoscaler_policy.arn
}


resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"
  values = [
    yamlencode({
      autoDiscovery = {
        clusterName = var.cluster_name
      }
      awsRegion = var.aws_region
      rbac = {
        serviceAccount = {
          create = false
          name   = "cluster-autoscaler"
        }
      }
      extraArgs = {
        balance-similar-node-groups = true
        skip-nodes-with-system-pods = false
      }
    })
  ]
}


module "aws_lb_controller" {
  source                = "./modules/aws-lb-controller"
  cluster_name          = var.cluster_name
  aws_region            = var.aws_region
  vpc_id                = module.eks_cluster.vpc_id
  cluster_endpoint      = module.eks_cluster.cluster_endpoint
  cluster_auth_token    = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = module.eks_cluster.cluster_certificate_authority_data
}

