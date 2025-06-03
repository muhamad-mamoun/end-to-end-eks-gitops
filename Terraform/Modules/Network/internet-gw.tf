resource "aws_internet_gateway" "main-igw" {
  tags   = { Name = "main-igw" }
  vpc_id = aws_vpc.main-vpc.id
}
