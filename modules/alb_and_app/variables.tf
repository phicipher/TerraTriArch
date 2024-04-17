variable "env_prefix" {
  description = "A prefix used to tag resources with the environment they are associated with"
}

variable "db_credentials_arn" {
  description = "The ARN of the database credentials secret stored in AWS Secrets Manager."
}

variable "image_name" {
  description = "AMI name pattern to use for filtering the AMI"
  default     = "amzn2-ami-hvm-*-x86_64-gp2"
}

variable "vpc_id" {
  description = "The VPC ID where resources will be created"
}

variable "public_subnets" {
  description = "A list of public subnet IDs for the load balancer"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of private subnet IDs for the application servers"
  type        = list(string)
}

variable "my_ip" {
  description = "IP address range that can be used to SSH to the instances"
}

variable "public_key_location" {
  description = "Location of the public key to be used for SSH access"
}

variable "instance_type" {
  description = "EC2 instance type for the application server"
  default     = "t2.micro"
}

variable "avail_zone" {
  description = "Availability zone where the instance will be launched"
}
