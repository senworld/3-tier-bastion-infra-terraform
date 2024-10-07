resource "aws_network_acl_rule" "bar" {
  network_acl_id = var.nacl_id
  rule_number    = var.rule_number
  egress         = var.egress
  protocol       = var.protocol
  rule_action    = var.action
  cidr_block     = var.cidr_range
  from_port      = var.from_port
  to_port        = var.to_port
}