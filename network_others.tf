#================================================X================================================#

################################
#Bastion and root vpc peer
################################

module "vpc_ab_peer" {
  source = "./Modules/vpc_peering"
  vpc_a_id = module.vpc_a.id
  vpc_b_id = module.vpc_b.id
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
  vpc_id = module.vpc_a.id
  tags_value = merge(var.web_tags,local.tags)
}

#================================================X================================================#

######################################
# Application Loadbalancer declaration
######################################

module "loadbalance_web" {
  source = "./Modules/load_balancer"
  sg_list = [ module.security_group_alb_a.sg_id ]
  subnet_list = [ for subnet in module.subnet_web: subnet.id ]
  lb_listening_port = 80
  lb_protocol = "HTTP"
  target_groups =  [module.target_group_web.arn]
  tags_value = merge(var.web_tags,local.tags) 
}

#================================================X================================================#
