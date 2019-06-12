output "public_ip" {
  value       = aws_eip.openvpn_ip.public_ip
  description = "The elastic IP address associated with the EC2 instance"
}

output "eip_id" {
  value       = aws_eip.openvpn_ip.id
  description = "Contains the EIP allocation ID"
}

output "private_ip" {
  value       = aws_instance.openvpn.private_ip
  description = "Contains the private IP address"
}

output "instance_id" {
  value       = aws_instance.openvpn.id
  description = "The ID of the EC2 instance"
}

output "instance_arn" {
  value       = aws_instance.openvpn.arn
  description = "The ARN of the instance"
}

output "iam_instance_profile" {
  value       = module.role.iam_instance_profile
  description = "The instance profile's ID"
}

output "iam_role" {
  value       = module.role.iam_role
  description = "The name of the role"
}

output "sg_id" {
  value       = module.sg.id
  description = "The security's ID"
}
