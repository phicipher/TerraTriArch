## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.ec2_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.ec2_secrets_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ec2_secrets_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ec2_secrets_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.ssh-key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_lb.front_end](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_security_group.alb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.app_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.latest-amazon-linux-image](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_avail_zone"></a> [avail\_zone](#input\_avail\_zone) | Availability zone where the instance will be launched | `any` | n/a | yes |
| <a name="input_db_credentials_arn"></a> [db\_credentials\_arn](#input\_db\_credentials\_arn) | The ARN of the database credentials secret stored in AWS Secrets Manager. | `any` | n/a | yes |
| <a name="input_env_prefix"></a> [env\_prefix](#input\_env\_prefix) | A prefix used to tag resources with the environment they are associated with | `any` | n/a | yes |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | AMI name pattern to use for filtering the AMI | `string` | `"amzn2-ami-hvm-*-x86_64-gp2"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type for the application server | `string` | `"t2.micro"` | no |
| <a name="input_my_ip"></a> [my\_ip](#input\_my\_ip) | IP address range that can be used to SSH to the instances | `any` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A list of private subnet IDs for the application servers | `list(string)` | n/a | yes |
| <a name="input_public_key_location"></a> [public\_key\_location](#input\_public\_key\_location) | Location of the public key to be used for SSH access | `any` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | A list of public subnet IDs for the load balancer | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where resources will be created | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_instance_id"></a> [app\_instance\_id](#output\_app\_instance\_id) | n/a |
| <a name="output_instance"></a> [instance](#output\_instance) | n/a |
| <a name="output_load_balancer_dns_name"></a> [load\_balancer\_dns\_name](#output\_load\_balancer\_dns\_name) | n/a |
