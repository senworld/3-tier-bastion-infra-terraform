resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr_range
  instance_tenancy = "default"

  tags = var.tags_value
}

resource "aws_default_route_table" "remove_default_rt" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  route = []
  tags = {
    Name = "default_rt"
  }
}

resource "aws_default_network_acl" "remove_default_nacl" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id
  tags = {
    Name = "default_nacl"
  }
}

resource "aws_default_security_group" "remove_default_sg" {
  vpc_id = aws_vpc.vpc.id
  ingress = []
  egress = []
  tags = {
    Name = "default_sg"
  }
}