
output "ec2_key_name" {
  description = "Name of the EC2 key pair"
  value       = aws_key_pair.create_key.key_name
}

output "ec2_key_pair_id" {
  description = "ID of the EC2 key pair"
  value       = aws_key_pair.create_key.id
}

output "private_key_file_path" {
  description = "Path where the private key PEM file is stored locally"
  value       = local_file.private_key.filename
}

