resource "aws_security_group" "sg" {
  name = var.sg_name
  vpc_id = var.vpc_id
  tags = var.tags_value
}