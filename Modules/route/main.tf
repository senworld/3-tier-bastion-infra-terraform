resource "aws_route" "route" {
  route_table_id = var.rt_id
  destination_cidr_block = var.dest_cidr_range
  gateway_id = var.igw_id
}