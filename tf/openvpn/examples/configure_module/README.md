# How to use the OpenVPN module

OpenVPN module provision one EC2 instance in a public subnet of your VPC. The instance itself should be used for VPN tunneling. There is in this repository an Ansible playbook which is responsible for installing the OpenVPN software on the EC2 instance.

## Module

The module will create one EC2 instance and attach an Elastic IP to the instance. Additionally it will create one security group and one IAM role for the instance.

Have a look into [main.tf](main.tf)

### Variables

The Module takes the arguments below.

| Variable | Description |
| --- | --- |
| source | module location |
| region | The AWS region for the OpenVPN EC2 instance |
| ami | EC2 AMI to use. Note that it has to be Ubuntu 16.04 |
| instance_type | EC2 instance type (t2.nano should be enough in most cases) |
| key_name | SSH key to use. Note that the key pair need to exist |
| subnet_id | Public subnet for the EC2 instance. The subnet has to exist |
| CIDR | IP range that can access any port of the EC2 instance. This can be used in case the instance is used for NAT |
| source_dest_check | Source destination check. AWS will not forward traffic trough the instance if this on is turned on |
| user_data | commands to execute during launch of the EC2 instance |
| tags | Instance Tags |
| volume_tags | Tags fort the EBS volume |

Have a look into the example files, [variables.tf](variables.tf) and [main.tf](main.tf).

### Output Variables

The OpenVPN module exports the following variables

| Variable | Description |
| --- | --- |
| public_ip | The elastic ip associated with the EC2 instance |
| instance_id | The ID of the EC2 instance |

## Provision OpenVPN

The OpenVPN module can be used with this example. Note that you need to redefine [variables.tf](variables.tf) to work with your AWS setup.

Run the following commands

```bash
terraform init
terraform apply
```

You can teardown the setup with the following command

```bash
terraform destroy
```
