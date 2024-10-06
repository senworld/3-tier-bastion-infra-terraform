resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr_range
  instance_tenancy = "default"

  tags = var.tags_value
}