resource "aws_vpc_security_group_ingress_rule" "ingress_example" {
  security_group_id = var.sg_id

  cidr_ipv4   = var.cidr_range
  from_port   = var.from_port
  ip_protocol = var.protocol
  to_port     = var.to_port
}