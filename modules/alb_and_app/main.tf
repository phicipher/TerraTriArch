data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = [var.image_name]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
resource "aws_iam_role" "ec2_secrets_role" {
  name = "ec2_secrets_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "ec2_secrets_policy" {
  name   = "ec2_secrets_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "secretsmanager:GetSecretValue",
        Resource = "${var.db_credentials_arn}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_secrets_policy_attachment" {
  role       = aws_iam_role.ec2_secrets_role.name
  policy_arn = aws_iam_policy.ec2_secrets_policy.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_secrets_role.name
}

resource "aws_lb" "front_end" {
  name               = "${var.env_prefix}-frontend-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnets

  drop_invalid_header_fields = true # Checkov recommendation 

  enable_deletion_protection = true # Checkov recommendation 

  tags = {
    Name = "${var.env_prefix}-frontendLoadBalancer"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "${var.env_prefix}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Webapp Ingress on port 80 for testing"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow Internet Access to WebApp Server"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_prefix}-alb_sg"
  }
}
resource "aws_security_group" "app_sg" {
  name        = "${var.env_prefix}-app-sg"
  description = "Security group for Application Servers"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH for build agent/Admin working on test environment"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "Webapp Ingress on port 80 for testing"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    description = "Allow Internet Access to WebApp Server"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_prefix}-app_sg"
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "server-key"
  public_key = file(var.public_key_location)
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.latest-amazon-linux-image.id
  instance_type = var.instance_type

  monitoring = true # Checkov recommendation 
  ebs_optimized = true # Checkov recommendation 
  metadata_options { # Checkov recommendation 
    http_endpoint = "enabled" 
    http_tokens   = "required" 
  }
  subnet_id     = element(var.private_subnets, 0)
  security_groups = [aws_security_group.app_sg.id]
  availability_zone = var.avail_zone

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  associate_public_ip_address = true
  key_name = aws_key_pair.ssh-key.key_name

  tags = {
    Name = "${var.env_prefix}-AppServer"
  }
}
