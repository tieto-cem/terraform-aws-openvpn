provider "aws" {
  region = "eu-west-1"
}

module "openvpn" {
  source            = "github.com/tieto-cem/terraform-aws-openvpn?ref=v1.3.0" # update to the newset release tag
  name              = "OpenVPN"
  ami               = "ami-0773391ae604c49a4"
  region            = "eu-west-1"
  instance_type     = "t3a.nano"
  key_name          = "openvpn-ssh-key"
  vpc_id            = "vpc-1q2w3e4r5t6y7u8i9"
  subnet_id         = "subnet-1a2s3d4f5g6h7j8k9"
  cidr              = "10.10.0.0/16"
  source_dest_check = false
  allow_nat         = true
  allow_ssh_port    = true
  ssh_cidr          = ["0.0.0.0/0"]
  user_data         = ""
  tags              = {
    Name = "OpenVPN"
  }
  volume_tags       = {
    Name = "OpenVPN"
  }
}
