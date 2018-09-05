variable "region" {
  description = "Regin to place openvpn instance"
  default     = "eu-west-1"
}

variable "ami" {
  description = "OpenVPN AMI passed from parrent"
}

variable "instance_type" {
  description = "EC2 Instance Type"
}

variable "key_name" {
  description = ""
}

variable "subnet_id" {
  description = ""
}

variable "cidr" {
  description = ""
}

variable "source_dest_check" {
  description = ""
  default     = false
}

variable "user_data" {
  description = ""
}

variable "tags" {
  type        = "map"
  description = ""
}

variable "volume_tags" {
  type        = "map"
  description = ""
}
