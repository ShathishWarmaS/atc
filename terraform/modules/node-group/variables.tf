variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "The name of the EKS node group"
  type        = string
  default     = "primary-node-group"
}

variable "node_role_arn" {
  description = "The IAM role ARN for the node group"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs for the node group"
  type        = list(string)
}

variable "instance_type" {
  description = "The instance type for the nodes"
  type        = string
  default     = "t2.micro"
}

variable "desired_capacity" {
  description = "Desired number of nodes in the node group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of nodes in the node group"
  type        = number
  default     = 5
}

variable "min_size" {
  description = "Minimum number of nodes in the node group"
  type        = number
  default     = 1
}

variable "max_unavailable" {
  description = "Maximum number of nodes unavailable during update"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}
variable "disk_size" {
  description = "The size of the disk attached to each node"
  type        = number
}

variable "volume_type" {
  description = "The type of volume for each node (e.g., gp3, gp2)"
  type        = string
}