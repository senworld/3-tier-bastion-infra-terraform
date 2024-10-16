resource "aws_subnet" "subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_range
  availability_zone  = var.subnet_az
  map_public_ip_on_launch = var.is_public
  tags = var.tags
}