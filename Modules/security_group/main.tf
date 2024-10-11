resource "aws_security_group" "sg" {
  name = var.sg_name
  vpc_id = var.vpc_id
  ingress = var.ingress_rule
  egress = var.egress_rule
  tags = var.tags_value
}