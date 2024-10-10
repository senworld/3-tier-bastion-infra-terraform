resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr_range
    gateway_id = "local"
  }
  
  dynamic "route" {
    for_each = var.route != null? var.route : []
    content {
      cidr_block = route.value["cidr_block"]
      gateway_id = route.value["gateway_id"]
    }
  }
  tags = var.tags_value
}