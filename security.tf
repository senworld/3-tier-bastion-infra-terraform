################################
#Webtier nacl_a declaration
################################
module "nacl_root" {
  source = "./Modules/nacl"
  vpc_id = module.vpc_a.id
  subnet_ids = concat(module.subnet_app[*].id,module.subnet_web[*].id,module.subnet_db[*].id)
  egress_rule = jsondecode(jsonencode(var.nacl_egress_rules))
  ingress_rule = jsondecode(jsonencode(var.nacl_ingress_rules))
  tags_value = merge(var.root_tags,local.tags)
}
###################################
#Webtier Security Group declaration
###################################
module "security_group_web_a" {
  source = "./Modules/security_group"
  vpc_id = module.vpc_a.id
  sg_name = "security_group_web_a"
  ingress_rule = jsondecode(jsonencode(var.web_sg_ingress_rules))
  egress_rule = jsondecode(jsonencode(var.web_sg_egress_rules))
  tags_value = merge(var.web_tags,local.tags)
}


#================================================X================================================#

################################
#Bastion nacl_b declaration
################################
module "nacl_bastion" {
  source = "./Modules/nacl"
  vpc_id = module.vpc_b.id
  subnet_ids = [module.subnet_bastion.id]
  egress_rule = jsondecode(jsonencode(var.nacl_egress_rules))
  ingress_rule = jsondecode(jsonencode(var.nacl_ingress_rules))
  tags_value = merge(var.bastion_tags,local.tags)
}

###################################
#Bastion Security Group declaration
###################################
module "security_group_bastion_a" {
  source = "./Modules/security_group"
  vpc_id = module.vpc_b.id
  sg_name = "security_group_bastion_a"
  ingress_rule = jsondecode(jsonencode(var.web_sg_ingress_rules))
  egress_rule = jsondecode(jsonencode(var.web_sg_egress_rules))
  tags_value = merge(var.bastion_tags,local.tags)
}