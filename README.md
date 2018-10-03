# OpenVPN Module

OpenVPN module install and configure [OpenVPN](https://openvpn.net/) with help of [Terraform](https://www.terraform.io/) and [Ansible](https://www.ansible.com/). The OpenVPN terraform module currently support only [AWS](https://aws.amazon.com/) but the Ansible playbook can be used for installing OpenVPN on an Ubunu machine from any infra provider.

## Getting started with OpenVPN Module

### Requirements

The OpenVPN module requires that an AWS account has already been provisioned with at least one public subnet in a VPC. The following list of requirements also is need to install the OpenVPN module.

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [Terraform](https://www.terraform.io/downloads.html)

### Provision the instance

There is an [example](tf/openvpn/examples/configure_module) on how to configure the module. Follow the example, redefine the variables and run

```bash
terraform init
terraform apply
```

The example will output `instance_id` and `public_ip`. The instance can now be accessed with the IP address trough SSH.

### Install OpenVPN

Ansible automatically install OpenVPN with all dependencies and configurations.

#### Configure Ansible

The Ansible playbook need to be configured before it's possible to install OpenVPN.

Create a new inventory, cem.

```bash
mkdir ansible/openvpn/inventories/cem
```

Copy the ansible [inventory example](ansible/openvpn/inventories/example/example-inventory)

```bash
cp ansible/openvpn/inventories/example/example-inventory ansible/openvpn/inventories/cem/cem-inventory
```

Redefine the inventory, change the host group "example" to "cem" and use the use the IP address that was outputted from the terraform script.

```bash
[cem]
18.203.25.235

[all:vars]
ansible_connection=ssh 
ansible_ssh_private_key_file=~/aws/cem/cem.pem
ansible_ssh_user=ubuntu
ansible_python_interpreter=/usr/bin/python3.5
```

Copy the ansible [group_vars example](ansible/openvpn/group_vars/example)

```bash
cp ansible/openvpn/group_vars/example ansible/openvpn/group_vars/cem
```

Redefine the group variables in the group_vars file, cem

| Variable | Description |
| --- | --- |
| VpnClients | List of VPN keys that should be generated |
| ServerName | Name of the server, will be part of keys etc |
| RedrirectTraffic | If `true` all traffic will get routed trough the VPN server. Normally this can be `false` |
| LocalNetwork | Clients will route all traffic trough the VPN server within this IP range |
| NetworkInterface | Network interface for the public IP |

#### Run ansible

Run the playbook in order to install OpenVPN and create user keys

```bash
cd ansible/openvpn
ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook install-openvpn.yml -i inventories/cem
```

#### Obtain client keys

The client keys exist on the server and can only be obtain with sudo rights.

Run the following command to obtain client keys

```bash
./obtain-keys.sh -i /location/to/private/ssh_key.pem -s ubuntu@IP_ADDRESS -c username
```
