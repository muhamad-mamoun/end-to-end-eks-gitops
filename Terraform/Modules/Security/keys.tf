resource "tls_private_key" "ssh-key-pair" {
  algorithm = "ED25519"
}

resource "local_file" "ssh-private-key" {
  content         = tls_private_key.ssh-key-pair.private_key_openssh
  filename        = "ssh-key"
  file_permission = "0600"
}

resource "local_file" "ssh-public-key" {
  content         = tls_private_key.ssh-key-pair.public_key_openssh
  filename        = "ssh-key.pub"
  file_permission = "0600"
}

resource "aws_key_pair" "bastion-server-key" {
  key_name   = "bastion-server-key"
  public_key = tls_private_key.ssh-key-pair.public_key_openssh
}
