resource "aws_route_table" "public-route-table" {
  tags   = { Name = "public-route-table" }
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }
}

resource "aws_route_table_association" "public-routes" {
  for_each = aws_subnet.public-subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table" "private-route-table" {
  tags   = { Name = "private-route-table" }
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public-nat.id
  }
}

resource "aws_route_table_association" "private-routes" {
  for_each = aws_subnet.private-subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private-route-table.id
}
