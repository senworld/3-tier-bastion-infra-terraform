resource "aws_route_table_association" "" {
  subnet_id      = aws_subnet.subnet_1a.id
  route_table_id = aws_route_table.bar.id
}