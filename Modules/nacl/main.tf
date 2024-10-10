resource "aws_network_acl" "nacl" {
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
  dynamic "egress" {
    for_each = var.egress_rule != null? var.egress_rule : []
    content{
      protocol   = egress.value["protocol"]
      rule_no    = egress.value["rule_no"]
      action     = egress.value["action"]
      cidr_block = egress.value["cidr_block"]
      from_port  = egress.value["from_port"]
      to_port    = egress.value["to_port"]
    }
  }
  dynamic "ingress" {
    for_each = var.ingress_rule != null? var.ingress_rule : []
    content{
      protocol   = ingress.value["protocol"]
      rule_no    = ingress.value["rule_no"]
      action     = ingress.value["action"]
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["from_port"]
      to_port    = ingress.value["to_port"]
    }
  }
  tags = var.tags_value
}

