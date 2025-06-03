output "main-vpc-id" {
  value = aws_vpc.main-vpc.id
}

output "public-subnets" {
  value = aws_subnet.public-subnets
}

output "private-subnets" {
  value = aws_subnet.private-subnets
}

output "bastion-server-sg-id" {
  value = aws_security_group.bastion-server-sg.id
}

output "control-plane-sg-id" {
  value = aws_security_group.control-plane-sg.id
}

output "worker-nodes-sg-id" {
  value = aws_security_group.worker-nodes-sg.id
}
