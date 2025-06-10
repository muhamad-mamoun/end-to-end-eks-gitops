resource "aws_security_group" "bastion-server-sg" {
  name        = "bastion-server-sg"
  description = "Allow SSH and HTTPS inbound traffic and all outbound traffic"

  vpc_id = aws_vpc.main-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.admin-public-ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "bastion-server-sg" }
}

resource "aws_security_group" "control-plane-sg" {
  name        = "control-plane-sg"
  description = "Allow HTTPS inbound traffic and all outbound traffic"

  vpc_id = aws_vpc.main-vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main-vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "control-plane-sg" }
}

resource "aws_security_group" "worker-nodes-sg" {
  name        = "worker-nodes-sg"
  description = "Allow SSH and HTTPS inbound traffic and all outbound traffic, also allow node-to-node communications"

  vpc_id = aws_vpc.main-vpc.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion-server-sg.id]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "worker-nodes-sg" }
}
