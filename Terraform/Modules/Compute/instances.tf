resource "aws_instance" "bastion-server" {
  tags = { Name = "bastion-server" }

  ami                         = var.bastion-server-ami-id
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  subnet_id                   = var.bastion-server-subnet-id

  key_name               = var.bastion-server-key-name
  vpc_security_group_ids = [var.bastion-server-sg-id]

  iam_instance_profile = var.bastion-server-instance-profile-name

  user_data                   = filebase64("${path.module}/startup-script.sh")
  user_data_replace_on_change = true
}
