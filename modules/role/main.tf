resource "aws_iam_role" "openvpn_role" {
  name               = "${var.name}_role"
  assume_role_policy = file("${path.module}/assume_role_policy.json")
}

resource "aws_iam_instance_profile" "openvpn_instance_profile" {
  name = "${var.name}_instance_profile"
  role = aws_iam_role.openvpn_role.id
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
  role       = aws_iam_role.openvpn_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
