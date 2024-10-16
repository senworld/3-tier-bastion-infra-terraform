resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id
  tags = var.tags
}

resource "aws_route" "route" {
  route_table_id = aws_route_table.route_table.id
  for_each = {for rule in var.route: rule.destination_cidr_block => rule}
  destination_cidr_block = each.key
  gateway_id = each.value.gateway_id != null? each.value.gateway_id : null
  nat_gateway_id = each.value.nat_gateway_id != null? each.value.nat_gateway_id : null
  vpc_peering_connection_id = each.value.vpc_peering_connection_id != null? each.value.vpc_peering_connection_id : null
  vpc_endpoint_id = each.value.vpc_endpoint_id != null? each.value.vpc_endpoint_id : null
}

resource "aws_route_table_association" "rt_sub_link" {
  route_table_id = aws_route_table.route_table.id
  subnet_id = var.subnet_id[count.index]
  count = length(var.subnet_id)
}