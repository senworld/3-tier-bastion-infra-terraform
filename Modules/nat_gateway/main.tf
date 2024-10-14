resource "aws_nat_gateway" "nat_gw" {
  allocation_id = var.elastic_ip_id
  subnet_id     = var.subnet_id
  depends_on = var.depends_on_igw
}