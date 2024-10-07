resource "aws_network_acl" "nacl" {
  vpc_id = var.vpc_id
  tags = var.tags_value
}