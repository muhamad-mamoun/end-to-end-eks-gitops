resource "aws_eip" "nat-gw-ip" {
  tags   = { Name = "nat-gw-ip" }
  domain = "vpc"
}
