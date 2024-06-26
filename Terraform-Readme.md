## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.45.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb_and_app"></a> [alb\_and\_app](#module\_alb\_and\_app) | ./modules/alb_and_app | n/a |
| <a name="module_database"></a> [database](#module\_database) | ./modules/database | n/a |
| <a name="module_tri-arch-vpc"></a> [tri-arch-vpc](#module\_tri-arch-vpc) | terraform-aws-modules/vpc/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_subnets_cidr_blocks"></a> [database\_subnets\_cidr\_blocks](#input\_database\_subnets\_cidr\_blocks) | A list of CIDR blocks dedicated for database subnets within the VPC. These are designed to isolate database resources in private subnets, enhancing security and performance. | `list(string)` | <pre>[<br>  "10.0.30.0/24"<br>]</pre> | no |
| <a name="input_env_prefix"></a> [env\_prefix](#input\_env\_prefix) | A prefix used to tag resources with the environment within which they are deployed, such as 'prod', 'dev', or 'test'. This helps in identifying and managing resources based on the environment. | `string` | `"Dev"` | no |
| <a name="input_private_subnet_cidr_blocks"></a> [private\_subnet\_cidr\_blocks](#input\_private\_subnet\_cidr\_blocks) | A list of CIDR blocks for the private subnets within the VPC. These subnets are typically used for backend services that do not require direct access from the Internet. | `list(string)` | <pre>[<br>  "10.0.10.0/24"<br>]</pre> | no |
| <a name="input_public_subnet_cidr_blocks"></a> [public\_subnet\_cidr\_blocks](#input\_public\_subnet\_cidr\_blocks) | A list of CIDR blocks for the public subnets within the VPC. These subnets are used for resources that need to be directly accessible from the Internet, such as web servers and load balancers. | `list(string)` | <pre>[<br>  "10.0.20.0/24"<br>]</pre> | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | The CIDR block for the VPC. This defines the IP address range available for all the subnets and resources within the VPC. Typical formats might be '10.0.0.0/16' or '192.168.0.0/16'. | `string` | `"10.0.0.0/16"` | no |

## Outputs

No outputs.
