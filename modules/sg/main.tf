resource "aws_security_group" "openvpn" {
  name        = var.name
  description = "Allow only 1194 publicly, ssh available with VPN access"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 1194
    to_port   = 1194
    protocol  = "udp"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
    description = "OpenVPN default port"
  }

  dynamic "ingress" {
    for_each = var.allow_ssh_port ? [1] : []
    content {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr_blocks = var.ssh_cidr
      description = "Allow SSH"
    }
  }

  dynamic "ingress" {
    for_each = var.allow_nat ? [1] : []
    content {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      cidr_blocks = [
        var.cidr,
      ]
      description = "NAT possibility"
    }
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  tags = {
    Name = "OpenVPN"
  }
}
