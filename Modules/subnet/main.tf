resource "aws_subnet" "subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_range
  availability_zone  = var.subnet_az
  tags = var.tags_value
}