resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr_range
    gateway_id = "local"
  }
  
  tags = var.tags_value
}