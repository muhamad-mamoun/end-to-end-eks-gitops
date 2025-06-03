resource "aws_nat_gateway" "public-nat" {
  tags          = { Name = "public-nat" }
  allocation_id = aws_eip.nat-gw-ip.id
  subnet_id     = aws_subnet.public-subnets["${var.nat-gw-subnet-name}"].id
}
