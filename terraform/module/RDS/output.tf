
output "rds_instance_id" {
  description = "RDS instance identifier"
  value       = aws_db_instance.postgres.id
}

output "rds_endpoint" {
  description = "RDS endpoint (hostname:port)"
  value       = aws_db_instance.postgres.endpoint
}

output "rds_address" {
  description = "RDS hostname/address"
  value       = aws_db_instance.postgres.address
}

output "rds_port" {
  description = "RDS port"
  value       = aws_db_instance.postgres.port
}

output "rds_db_name" {
  description = "Database name"
  value       = aws_db_instance.postgres.db_name
}

output "rds_subnet_group_name" {
  description = "DB subnet group name"
  value       = aws_db_subnet_group.strapi.name
}