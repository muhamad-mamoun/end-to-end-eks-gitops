resource "aws_subnet" "public-subnets" {
  for_each = { for subnet in var.public-subnets : subnet.name => subnet }

  tags              = { Name = each.key }
  vpc_id            = aws_vpc.main-vpc.id
  availability_zone = each.value.zone
  cidr_block        = each.value.cidr
}

resource "aws_subnet" "private-subnets" {
  for_each = { for subnet in var.private-subnets : subnet.name => subnet }

  tags              = { Name = each.key }
  vpc_id            = aws_vpc.main-vpc.id
  availability_zone = each.value.zone
  cidr_block        = each.value.cidr
}
