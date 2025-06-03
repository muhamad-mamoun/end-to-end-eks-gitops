output "bastion-server-public-ip" {
  value = aws_instance.bastion-server.public_ip
}
