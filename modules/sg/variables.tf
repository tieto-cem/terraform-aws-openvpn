variable "name" {
  description = "Security group name"
  type        = string
}

variable "cidr" {
  description = "Ingress IP range for NAT"
  default     = "0.0.0.0/0"
  type        = string
}

variable "allow_nat" {
  description = "Should there be nat possibility"
  default     = true
  type        = bool
}

variable "vpc_id" {
  description = "VPC id where to place the security group"
  type        = string
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
