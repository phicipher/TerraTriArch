resource "aws_iam_role" "rds_secrets_role" {
  name = "rds_secrets_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "rds.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "rds_secrets_policy" {
  name   = "rds_secrets_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        Resource = "${aws_secretsmanager_secret.db_credentials.arn}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds_secrets_policy_attachment" {
  role       = aws_iam_role.rds_secrets_role.name
  policy_arn = aws_iam_policy.rds_secrets_policy.arn
}

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "db_credentials" {
  name = "db_credentials"
  description = "Database credentials for application"
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
  })
}

data "aws_secretsmanager_secret_version" "password" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
}

resource "aws_db_instance" "app_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  instance_class       = var.instance_class
  engine               = "mysql"
  engine_version       = "8.0"
  username             = var.db_username
  password             = jsondecode(data.aws_secretsmanager_secret_version.password.secret_string)["password"]
  db_name              = var.database_name
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  #vpc_security_group_ids = [aws_security_group.alb_sg.id]
  multi_az             = var.enable_multi_az
  iam_database_authentication_enabled = true
  enabled_cloudwatch_logs_exports = ["general", "error", "slowquery"] # Checkov recommendation 
  auto_minor_version_upgrade = true # Checkov recommendation 
  monitoring_interval  = 5 # Checkov recommendation 
  deletion_protection  = true # Checkov recommendation 
  performance_insights_enabled = true # Checkov recommendation
  copy_tags_to_snapshot     = true # Checkov recommendation

  tags = {
    Name = "${var.env_prefix}-AppDb"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = lower("${var.env_prefix}-db-subnet-group")
  subnet_ids = var.database_subnets

  tags = {
    Name = "${var.env_prefix}-DbSubnetGroup"
  }
}
