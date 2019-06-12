variable "name" {
  description = "Security group name"
}

variable "cidr" {
  description = "Ingress IP range"
}

variable "vpc_id" {
  description = "VPC id where to place the security group"
}
