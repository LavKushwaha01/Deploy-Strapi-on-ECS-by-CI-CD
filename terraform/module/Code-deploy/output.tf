
output "codedeploy_app_name" {
  description = "CodeDeploy application name (ECS)"
  value       = aws_codedeploy_app.ecs.name
}

output "codedeploy_app_arn" {
  description = "ARN of the CodeDeploy ECS application"
  value       = aws_codedeploy_app.ecs.arn
}

output "codedeploy_deployment_group_name" {
  description = "CodeDeploy deployment group name"
  value       = aws_codedeploy_deployment_group.ecs.deployment_group_name
}

output "codedeploy_deployment_group_id" {
  description = "CodeDeploy deployment group ID"
  value       = aws_codedeploy_deployment_group.ecs.id
}