provider "aws" {
  region = var.region
}

module "openvpn" {
  source        = "github.com/tieto-cem/terraform-aws-openvpn?ref=v1.2.0" # update to the newset release tag
  ami           = var.amis[var.region]
  region        = var.region
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_id        = var.vpc_id
  subnet_id     = var.subnet_id
  cidr          = var.cidr
  user_data     = var.user_data
  tags          = var.tags
  volume_tags   = var.volume_tags
}
