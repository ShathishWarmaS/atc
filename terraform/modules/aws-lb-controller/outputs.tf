output "alb_controller_role_arn" {
  description = "ARN of the IAM role for AWS Load Balancer Controller"
  value       = aws_iam_role.alb_controller_role.arn
}

output "alb_controller_policy_arn" {
  description = "ARN of the IAM policy for AWS Load Balancer Controller"
  value       = aws_iam_policy.alb_controller_policy.arn
}

