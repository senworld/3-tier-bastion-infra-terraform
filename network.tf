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


module "elastic_ip_a" {
  source = "./Modules/elastic_ip"
  ec2_id = module.ec2_web_a.ec2_id
  tags_value = {
    Name = "elastic_ip_a"
    Tier = "Main"
  }
}