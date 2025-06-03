variable "vpc-cidr" {
  type = string
}

variable "public-subnets" {
  type = list(object({
    name = string
    cidr = string
    zone = string
  }))
}

variable "private-subnets" {
  type = list(object({
    name = string
    cidr = string
    zone = string
  }))
}

variable "nat-gw-subnet-name" {
  type = string
}

variable "admin-public-ip" {
  type = string
}
