##################################
#Application root vpc declaration
##################################
module "vpc_main" {
  source = "./Modules/vpc"
  cidr_range = "192.168.0.0/16"
  tags_value = merge(var.root_tags,local.tags)
}

module "internet_gateway_main"{
  source = "./Modules/internet_gateway"
  vpc_id = module.vpc_main.id
  tags_value = merge(var.root_tags,local.tags)
}

################################
#Subnet declaration
################################

module "subnet_main" {
  for_each = {for name in var.subnet_main: name.tags.Name => name}
  source = "./Modules/subnet"
  vpc_id = module.vpc_main.id
  cidr_range = each.value.cidr_range
  subnet_az = each.value.subnet_az
  is_public = each.value.is_public
  tags = each.value.tags
}

################################
#Route declaration
################################

module "route_table_public" {
  source = "./Modules/route_table"
  vpc_id = module.vpc_main.id
  subnet_id = local.public_subnets
  route = local.public_route
  tags = merge({Name="Public"},local.tags)
}

module "route_table_private" {
  source = "./Modules/route_table"
  vpc_id = module.vpc_main.id
  subnet_id = local.private_subnets
  route = local.private_route
  tags = merge({Name="Private"},local.tags)
}

#================================================X================================================#

##################################
# JumpServer/Bastion vpc declaration
##################################
module "vpc_bastion" {
  source = "./Modules/vpc"
  cidr_range = "10.0.0.0/16"
  tags_value = merge(var.bastion_tags,local.tags)
}

module "internet_gateway_bastion"{
  source = "./Modules/internet_gateway"
  vpc_id = module.vpc_bastion.id
  tags_value = merge(var.bastion_tags,local.tags)
}

################################
#Bastion subnet declaration
################################

module "subnet_bastion" {
  for_each = {for name in var.subnet_bastion: name.tags.Name => name}
  source = "./Modules/subnet"
  vpc_id = module.vpc_bastion.id
  cidr_range = each.value.cidr_range
  subnet_az = each.value.subnet_az
  is_public = each.value.is_public
  tags = each.value.tags
}

module "route_table_bastion" {
  source = "./Modules/route_table"
  vpc_id = module.vpc_bastion.id
  subnet_id = local.bastion_subnets
  route = local.bastion_route
  tags = merge(var.bastion_tags,local.tags)
}