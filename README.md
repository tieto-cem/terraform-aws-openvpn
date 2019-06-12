# OpenVPN Terraform Module

OpenVPN module provision one EC2 instance in a public subnet of your VPC. The instance itself should be used for VPN tunneling. There is an Ansible Playbook example in the Ansible [openvpn-server-role](https://github.com/tieto-cem/openvpn-server-role) repository.

## Module

The module will create one EC2 instance and attach an Elastic IP to the instance. Additionally it will create one security group and one IAM role for the instance.

Have a look into [main.tf](https://github.com/tieto-cem/terraform-aws-openvpn/blob/master/examples/configure_module/main.tf)

Note that this module is written for terraform client ver 0.12 or later. Use release 1.0.0 for prior terraform versions.

### Variables

The Module takes the arguments below.

| Variable | Description |
| --- | --- |
| source | module location |
| name | Unique name for the module |
| region | The AWS region for the OpenVPN EC2 instance |
| ami | EC2 AMI to use. Note that it has to be Ubuntu 16.04 |
| instance_type | EC2 instance type (t3a.nano should be enough in most cases) |
| key_name | SSH key to use. Note that the key pair need to exist |
| vpc_id | ID of the VPC to use. The VPC has to exist |
| subnet_id | Public subnet for the EC2 instance. The subnet has to exist |
| cidr | IP range that can access any port of the EC2 instance. This can be used in case the instance is used for NAT |
| source_dest_check | Source destination check. AWS will not forward traffic trough the instance if this on is turned on |
| user_data | commands to execute during launch of the EC2 instance |
| tags | Instance Tags |
| volume_tags | Tags fort the EBS volume |

Have a look into the example files, [variables.tf](https://github.com/tieto-cem/terraform-aws-openvpn/blob/master/examples/configure_module/variables.tf) and [main.tf](https://github.com/tieto-cem/terraform-aws-openvpn/blob/master/examples/configure_module/main.tf).

### Output Variables

The OpenVPN module exports the following variables

| Variable | Description |
| --- | --- |
| public_ip | The elastic IP address associated with the EC2 instance |
| private_ip | Contains the private IP address |
| instance_id | The ID of the EC2 instance |
| eip_id | Contains the EIP allocation ID |
| instance_arn | The ARN of the instance |
| iam_instance_profile | The instance profile's ID |
| iam_role | The name of the role |
| sg_id | The security's ID |

## Provision OpenVPN

The OpenVPN module can be used with [this example](https://github.com/tieto-cem/terraform-aws-openvpn/blob/master/examples/configure_module). Note that you need to redefine [variables.tf](https://github.com/tieto-cem/terraform-aws-openvpn/blob/master/examples/configure_module/variables.tf) to work with your AWS setup.

Run the following commands

```bash
terraform init
terraform apply
```

You can teardown the setup with the following command

```bash
terraform destroy
```
