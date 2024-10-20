######################################
# NAT gateway on vpc_main declaration
######################################
module "nat_gateway_main" {
  source = "./Modules/nat_gateway"
  subnet_id = local.public_subnets[0]
}
#================================================X================================================#

################################
#Bastion and root vpc peer
################################

module "vpc_peer" {
  source = "./Modules/vpc_peering"
  vpc_a_id = module.vpc_main.id
  vpc_b_id = module.vpc_bastion.id
  tags_value = merge({Name = "Bastion & Root Peer"},local.tags)
}

#================================================X================================================#

#########################################
#Target Group declaration
#########################################
module "target_group_web" {
  source = "./Modules/target_group"
  target_port = 80
  protocol = "HTTP"
  vpc_id = module.vpc_main.id
  tags_value = merge(var.web_tags,local.tags)
}

#================================================X================================================#

######################################
# Application Loadbalancer declaration
######################################

# module "loadbalance_web" {
#   source = "./Modules/load_balancer"
#   sg_list = [ module.security_group_alb_a.sg_id ]
#   subnet_list = local.public_subnets
#   lb_listening_port = 80
#   lb_protocol = "HTTP"
#   target_groups =  [module.target_group_web.arn]
#   tags_value = merge(var.web_tags,local.tags) 
# }

#================================================X================================================#

