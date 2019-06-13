resource "aws_iam_role" "openvpn_role" {
  name               = "${var.name}_role"
  assume_role_policy = file("${path.module}/assume_role_policy.json")
}

resource "aws_iam_instance_profile" "openvpn_instance_profile" {
  name = "${var.name}_instance_profile"
  role = aws_iam_role.openvpn_role.id
}

resource "aws_iam_role_policy" "openvpn_role_policy" {
  name   = "${var.name}_role_policy"
  role   = aws_iam_role.openvpn_role.id
  policy = file("${path.module}/role_policy.json")
}
