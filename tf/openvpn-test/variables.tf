variable "region" {
  default = "eu-west-1"
}

variable "amis" {
  type    = "map"
  default = {
    "eu-west-1" = "ami-0773391ae604c49a4"
  }
}

variable "instance_type" {
  default = "t2.nano"
}

variable "key_name" {
  default = "metso"
}

variable "subnet_id" {
  default = "subnet-68839330"
}

variable "CIDR" {
  default = "172.31.0.0/16"
}

variable "source_dest_check" {
  default = false
}

variable "user_data" {
  default = ""
}

variable "tags" {
  type    = "map"
  default = {
    Name = "OpenVPN"
  }
}

variable "volume_tags" {
  type    = "map"
  default = {
    Name = "OpenVPN"
  }
}
