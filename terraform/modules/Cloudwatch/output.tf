output "ecs_dashboard_name" {
  description = "Name of the ECS CloudWatch dashboard"
  value       = aws_cloudwatch_dashboard.ecs_dashboard.dashboard_name
}

output "ecs_dashboard_arn" {
  description = "ARN of the ECS CloudWatch dashboard"
  value       = aws_cloudwatch_dashboard.ecs_dashboard.dashboard_arn
}

output "ecs_dashboard_url" {
  description = "URL to view the ECS CloudWatch dashboard in AWS Console"
  value       = "https://${var.region}.console.aws.amazon.com/cloudwatch/home?region=${var.region}#dashboards:name=${aws_cloudwatch_dashboard.ecs_dashboard.dashboard_name}"
}