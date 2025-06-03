resource "aws_iam_instance_profile" "bastion-server-instance-profile" {
  name = "bastion-server-instance-profile"
  role = aws_iam_role.bastion-server-role.name
}
