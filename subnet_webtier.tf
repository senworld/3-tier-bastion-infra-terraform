################################
#Webtier route_a declaration
################################

module "route_table_web_a" {
  source = "./Modules/route_table"
  cidr_range = module.vpc_a.cidr_block
  vpc_id = module.vpc_a.id
  route = [
    {
      cidr_block="0.0.0.0/0"
      gateway_id=module.internet_gateway_a.id
    }
  ]
  tags_value = {
    Name = "route_table_web_a"
    Tier = "Web"
  }
}

################################
#Webtier subnet_web_a declaration
################################

module "subnet_web_a" {
  source = "./Modules/subnet"
  cidr_range = "192.168.1.0/24"
  vpc_id = module.vpc_a.id
  subnet_az = "ap-south-1a"
  tags_value = {
    Name = "subnet_web_a"
    Tier = "Web"
  }
}

module "rt_subnet_link_1a" {
  source = "./Modules/rt_subnet_link"
  subnet_id = module.subnet_web_a.id
  route_table_id = module.route_table_web_a.id
}

################################
#Webtier subnet_web_b declaration
################################

module "subnet_web_b" {
  source = "./Modules/subnet"
  cidr_range = "192.168.2.0/24"
  vpc_id = module.vpc_a.id
  subnet_az = "ap-south-1b"
  tags_value = {
    Name = "subnet_web_b"
    Tier = "Web"
  }
}

module "rt_subnet_link_1b" {
  source = "./Modules/rt_subnet_link"
  subnet_id = module.subnet_web_b.id
  route_table_id = module.route_table_web_a.id
}

################################
#Webtier nacl_a declaration
################################

module "nacl_web_a" {
  source = "./Modules/nacl"
  vpc_id = module.vpc_a.id
  subnet_ids = [ module.subnet_web_a.id,module.subnet_web_b.id ]
  egress_rule = [{
    protocol = -1
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }
  ]
  ingress_rule = [{
    protocol = -1
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }
  ]
  tags_value = {
    Name = "nacl_web_a"
    Tier = "Web"
  }
}