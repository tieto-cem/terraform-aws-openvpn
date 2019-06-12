output "iam_instance_profile" {
  value = aws_iam_instance_profile.openvpn_instance_profile.id
}

output "iam_role" {
  value = aws_iam_role.openvpn_role.id
}
