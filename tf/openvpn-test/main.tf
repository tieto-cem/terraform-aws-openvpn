provider "aws" {
  region = "${var.region}"
}

module "openvpn" {
  source        = "../openvpn"
  ami           = "${lookup(var.amis, var.region)}"
  region        = "${var.region}}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"
  subnet_id     = "${var.subnet_id}"
  cidr          = "${var.CIDR}"
  user_data     = "${var.user_data}"
  tags          = "${var.tags}"
  volume_tags   = "${var.volume_tags}"
}
