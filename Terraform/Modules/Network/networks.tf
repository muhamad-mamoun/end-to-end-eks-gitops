resource "aws_vpc" "main-vpc" {
  tags       = { Name = "main-vpc" }
  cidr_block = var.vpc-cidr
}
