# OpenVPN Module

OpenVPN module install and configure [OpenVPN](https://openvpn.net/) with help of [Terraform](https://www.terraform.io/) and [Ansible](https://www.ansible.com/). The OpenVPN terraform module currently support only [AWS](https://aws.amazon.com/) but the Ansible playbook can be used for installing OpenVPN on an Ubunu machine from any infra provider.

## Getting started with OpenVPN Module

### Requirements

The OpenVPN module requires that an AWS account has already been provisioned with at least one public subnet in a VPC. The following list of requirements is also need to install the OpenVPN module.

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [Terraform](https://www.terraform.io/downloads.html)

### Provision the instance

There is an [example](tf/openvpn/examples/configure_module) on how to configure the module. Follow the example, redefine the variables and run

```bash
terraform init
terraform apply
```

The example will output `instance_id` and `public_ip`. The instance can now be accessed with the IP address trough SSH.

### Install OpenVPN on the Server

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

Redefine the inventory, change the host group "example" to "cem" and use the IP address that was outputted from the terraform script.

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

### Client installation of OpenVPN

#### Mac OS Client

Install stable version of [Tunnelblick](https://tunnelblick.net/downloads.html).

Extract your key file (your-name.tar.gz) into an empty directory e.g. vpn. Run the commands in a terminal window

```bash
mkdir ~/Documents/vpn && cd ~/Documents/vpn
tar zxf /location/to/your-name.tar.gz
```

Open Finder and locate the folder `~/Documents/vpn`.

Double click on the the conf file e.g. cem-openvpn-your-name.conf and choose to install for "Only Me".

Click on the small Tunnelblick icon in the top menu bar and choose "Connect cem-openvpn-your-name".

#### Linux Client (Ubuntu 16.04 example)

Install OpenVPN

```bash
wget -O - https://swupdate.openvpn.net/repos/repo-public.gpg | sudo apt-key add -
echo "deb http://build.openvpn.net/debian/openvpn/release/2.4 xenial main" | sudo tee /etc/apt/sources.list.d/openvpn-aptrepo.list
sudo apt update && sudo apt install openvpn
```

Extract your key file (your-name.tar.gz) into `/etc/openvpn`.

```bash
cd /etc/openvpn/
sudo tar zxf /location/to/your-name.tar.gz
```

Start OpenVPN client

```bash
sudo systemctl status openvpn@cem-openvpn-your-name
```

Stop OpenVPN client

```bash
sudo systemctl stop openvpn@cem-openvpn-your-name
```

#### Windows Client

Install latest version of [OpenVPN](https://openvpn.net/index.php/download/community-downloads.html) for Windows.

Extract Extract your key file (your-name.tar.gz) into `C:\Program Files\OpenVPN\config`. WinZip can be used for extracting .tar.gz files.

Right click on the small OpenVPN icon in the windows taskbar on the right hand bottom corner and select connect.
