
############################

output "ecs_security_group_id" {
  description = "Security Group ID for ECS service"
  value       = aws_security_group.ecs_sg.id
}

output "ecs_security_group_name" {
  description = "Security Group name for ECS service"
  value       = aws_security_group.ecs_sg.name
}

output "rds_security_group_id" {
  description = "Security Group ID for RDS"
  value       = aws_security_group.rds_sg.id
}

output "alb_security_group_id" {
  description = "Security Group ID for ALB"
  value       = aws_security_group.alb_sg.id
}

output "alb_security_group_name" {
  description = "Security Group name for ALB"
  value       = aws_security_group.alb_sg.name
}