terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  // Ensure to use a version that is compatible with your requirements
    }
  }
}

provider "aws" {
    region = "eu-west-2"
}

data "aws_availability_zones" "available" {}

module "tri-arch-vpc" {
  source = "terraform-aws-modules/vpc/aws"

    name = "tri-arch-vpc"
    cidr = var.vpc_cidr_block

    azs = data.aws_availability_zones.available.names 
    private_subnets = var.private_subnet_cidr_blocks
    public_subnets = var.public_subnet_cidr_blocks
    database_subnets = var.database_subnets_cidr_blocks


    enable_nat_gateway = true
    single_nat_gateway = true
    enable_dns_hostnames = true

    tags = {
    Name = "tri-arch-vpc"
    Terraform = "true"
    Environment = var.env_prefix
    }
    public_subnet_tags = {
    Name = "public-tri-arch-vpc"
    Terraform = "true"
    Environment = "dev"
    }
    
    private_subnet_tags = {
    Name = "private-tri-arch-vpc"
    Terraform = "true"
    Environment = var.env_prefix

    }
    database_subnet_tags = {
    Name = "database-tri-arch-vpc"
    Terraform = "true"
    Environment = var.env_prefix

    }
}

module "alb_and_app" {
  source              = "./modules/alb_and_app"
  env_prefix          = var.env_prefix
  vpc_id              = module.tri-arch-vpc.vpc_id
  public_subnets      = module.tri-arch-vpc.public_subnets
  private_subnets     = module.tri-arch-vpc.private_subnets
  db_credentials_arn  = module.database.db_credentials_arn
  my_ip               = "192.0.2.1/32"
  public_key_location = "~/.ssh/id_rsa.pub"
  instance_type       = "t2.micro"
  avail_zone          = length(data.aws_availability_zones.available.names) - 1
}

module "database" {
  source          = "./modules/database"
  env_prefix      = var.env_prefix
  instance_class  = "db.t3.micro"
  db_username     = "dbadmin"
  database_name   = "mydatabase"
  database_subnets = module.tri-arch-vpc.database_subnets
  enable_multi_az = false  // default is false Enable Multi-AZ for high availability in production
}
