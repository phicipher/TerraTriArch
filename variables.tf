variable "env_prefix" {
  description = "A prefix used to tag resources with the environment within which they are deployed, such as 'prod', 'dev', or 'test'. This helps in identifying and managing resources based on the environment."
  type        = string
  default = "Dev"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC. This defines the IP address range available for all the subnets and resources within the VPC. Typical formats might be '10.0.0.0/16' or '192.168.0.0/16'."
  type        = string
  default = "10.0.0.0/16"
}

variable "private_subnet_cidr_blocks" {
  description = "A list of CIDR blocks for the private subnets within the VPC. These subnets are typically used for backend services that do not require direct access from the Internet."
  type        = list(string)
  default = [ "10.0.10.0/24" ]
}

variable "public_subnet_cidr_blocks" {
  description = "A list of CIDR blocks for the public subnets within the VPC. These subnets are used for resources that need to be directly accessible from the Internet, such as web servers and load balancers."
  type        = list(string)
  default = [ "10.0.20.0/24" ]  
}

variable "database_subnets_cidr_blocks" {
  description = "A list of CIDR blocks dedicated for database subnets within the VPC. These are designed to isolate database resources in private subnets, enhancing security and performance."
  type        = list(string)
  default = [ "10.0.30.0/24" ]
}