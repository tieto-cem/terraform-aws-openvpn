resource "aws_iam_role" "openvpn_role" {
  name               = "openvpn_role"
  assume_role_policy = file("${path.module}/assume_role_policy.json")
}

resource "aws_iam_instance_profile" "openvpn_instance_profile" {
  name = "openvpn_instance_profile"
  role = "openvpn_role"
}

resource "aws_iam_role_policy" "openvpn_role_policy" {
  name   = "openvpn_role_policy"
  role   = aws_iam_role.openvpn_role.id
  policy = file("${path.module}/role_policy.json")
}
