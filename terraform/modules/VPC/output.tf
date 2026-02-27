
output "vpc_id" {
  description = "Default VPC ID"
  value       = data.aws_vpc.default.id
}

output "vpc_cidr_block" {
  description = "CIDR block of default VPC"
  value       = data.aws_vpc.default.cidr_block
}

output "alb_subnet_ids" {
  description = "Subnet IDs used by ALB/ECS (default subnets)"
  value       = data.aws_subnets.alb_subnets.ids
}

output "alb_subnet_azs" {
  description = "Availability Zones of ALB subnets"
  value       = data.aws_subnets.alb_subnets.availability_zones
}