module "vpc_a" {
  source = "./Modules/vpc"
  cidr_range = "192.168.0.0/16"
  tags_value = {
    Name = "vpc_a"
    Tier = "Main"
  }
}

module "internet_gateway_a"{
  source = "./Modules/internet_gateway"
  vpc_id = module.vpc_a.id
  tags_value = {
    Name = "internet_gateway_a"
    Tier = "Main"
  }
}

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

module "route_table_1a" {
  source = "./Modules/route_table"
  cidr_range = module.vpc_a.cidr_block
  vpc_id = module.vpc_a.id
  tags_value = {
    Name = "route_table_1a"
    Tier = "Web"
  }
}

module "rt_subnet_link_1a" {
  source = "./Modules/rt_subnet_link"
  subnet_id = module.subnet_1a.id
  route_table_id = module.route_table_1a.id
}