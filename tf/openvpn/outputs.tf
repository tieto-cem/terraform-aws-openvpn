output "public_ip" {
  value = "${aws_eip.openvpn_ip.public_ip}"
}

output "instance_id" {
  value = "${aws_instance.openvpn.id}"
}

