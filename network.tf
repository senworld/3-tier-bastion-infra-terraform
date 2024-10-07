########################
#Main vpc_a declaration
########################
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