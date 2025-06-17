region = "us-east-1"

vpc-cidr = "10.0.0.0/16"

public-subnets = [
  {
    name = "public-subnet-1"
    cidr = "10.0.1.0/24"
    zone = "us-east-1a"
  },
  {
    name = "public-subnet-2"
    cidr = "10.0.2.0/24"
    zone = "us-east-1b"
  },
  {
    name = "public-subnet-3"
    cidr = "10.0.3.0/24"
    zone = "us-east-1c"
  }
]

private-subnets = [
  {
    name = "private-subnet-1"
    cidr = "10.0.4.0/24"
    zone = "us-east-1a"
  },
  {
    name = "private-subnet-2"
    cidr = "10.0.5.0/24"
    zone = "us-east-1b"
  },
  {
    name = "private-subnet-3"
    cidr = "10.0.6.0/24"
    zone = "us-east-1c"
  }
]

ecr-repositories = ["frontend", "backend"]

nat-gw-subnet-name         = "public-subnet-1"
bastion-server-subnet-name = "public-subnet-2"
bastion-server-ami-id      = "ami-0a7d80731ae1b2435"

jenkins-ebs-zone      = "us-east-1a"
application-namespace = "webapp"

prometheus-namespace = "monitoring"
prometheus-ebs-zone  = "us-east-1c"
