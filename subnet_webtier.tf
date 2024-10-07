################################
#Webtier nacl_a declaration
################################

module "nacl_web_a" {
  source = "./Modules/nacl"
  vpc_id = module.vpc_a.id
  tags_value = {
    Name = "nacl_a"
    Tier = "Web"
  }
}

module "nacl_web_route_1" {
  source = "./Modules/nacl_rule"
  nacl_id = module.nacl_web_a.id
  rule_number = 100
  egress = false
  protocol = "-1"
  action = "deny"
  cidr_range = "0.0.0.0/0"
  from_port = "0"
  to_port = "65535"
}

# module "nacl_web_route_2" {
#   source = "./Modules/nacl_rule"
#   nacl_id = module.nacl_web_a.id
#   rule_number = 32766
#   egress = false
#   protocol = "-1"
#   action = "deny"
#   cidr_range = "0.0.0.0/0"
#   from_port = "0"
#   to_port = "65535"
# }

################################
#Webtier route_a declaration
################################

module "route_table_web_a" {
  source = "./Modules/route_table"
  cidr_range = module.vpc_a.cidr_block
  vpc_id = module.vpc_a.id
  tags_value = {
    Name = "route_table_1a"
    Tier = "Web"
  }
}

module "route_add_igw_a" {
  source = "./Modules/route"
  igw_id = module.internet_gateway_a.id
  dest_cidr_range = "0.0.0.0/0"
  rt_id = module.route_table_web_a.id
}

################################
#Webtier subnet_1a declaration
################################

module "subnet_1a" {
  source = "./Modules/subnet"
  cidr_range = "192.168.1.0/24"
  vpc_id = module.vpc_a.id
  subnet_az = "ap-south-1a"
  tags_value = {
    Name = "subnet_1a"
    Tier = "Web"
  }
}

module "rt_subnet_link_1a" {
  source = "./Modules/rt_subnet_link"
  subnet_id = module.subnet_1a.id
  route_table_id = module.route_table_web_a.id
}

module "nacl_subnet_link_1a" {
  source = "./Modules/nacl_subnet_link"
  subnet_id = module.subnet_1a.id
  nacl_id = module.nacl_web_a.id
}

################################
#Webtier subnet_1b declaration
################################

module "subnet_1b" {
  source = "./Modules/subnet"
  cidr_range = "192.168.2.0/24"
  vpc_id = module.vpc_a.id
  subnet_az = "ap-south-1b"
  tags_value = {
    Name = "subnet_1b"
    Tier = "Web"
  }
}

module "rt_subnet_link_1b" {
  source = "./Modules/rt_subnet_link"
  subnet_id = module.subnet_1b.id
  route_table_id = module.route_table_web_a.id
}

module "nacl_subnet_link_1b" {
  source = "./Modules/nacl_subnet_link"
  subnet_id = module.subnet_1b.id
  nacl_id = module.nacl_web_a.id
}