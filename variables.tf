variable "name" {
  description = "Unique name of the module"
  default     = "openvpn"
}

variable "region" {
  description = "Region to place openvpn instance"
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

variable "vpc_id" {
  description = "VPC id where to place the security group"
}

variable "subnet_id" {
  description = ""
}

variable "cidr" {
  description = ""
}

variable "allow_nat" {
  description = "Should there be nat possibility"
  default     = true
  type        = bool
}

variable "allow_ssh_port" {
  description = "Should the ssh port be open"
  default     = true
  type        = bool
}

variable "ssh_cidr" {
  description = "Allowd nbetwork range for SSH"
  type        = list(string)
  default     = [
    "0.0.0.0/0"
  ]
}

variable "source_dest_check" {
  description = ""
  default     = false
}

variable "user_data" {
  description = ""
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = ""
}

variable "volume_tags" {
  type        = map(string)
  description = ""
}
