output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.app_db.address
}

output "db_instance_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.app_db.endpoint
}

output "db_subnet_group_name" {
  description = "The name of the database subnet group"
  value       = aws_db_subnet_group.db_subnet_group.name
}

output "db_credentials_arn" {
  value = aws_secretsmanager_secret.db_credentials.arn
  description = "The ARN of the database credentials secret stored in AWS Secrets Manager."
}