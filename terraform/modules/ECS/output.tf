
output "ecs_cluster_name" {
  description = "ECS Cluster name"
  value       = aws_ecs_cluster.this.name
}

output "ecs_cluster_arn" {
  description = "ECS Cluster ARN"
  value       = aws_ecs_cluster.this.arn
}

output "ecs_service_name" {
  description = "ECS Service name"
  value       = aws_ecs_service.strapi.name
}

output "ecs_service_arn" {
  description = "ECS Service ARN"
  value       = aws_ecs_service.strapi.id
}

output "ecs_task_definition_family" {
  description = "ECS Task Definition family"
  value       = aws_ecs_task_definition.strapi.family
}

output "ecs_task_definition_arn" {
  description = "ECS Task Definition ARN"
  value       = aws_ecs_task_definition.strapi.arn
}