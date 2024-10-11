################################
#Web ec2 declaration
################################
module "ec2_web" {
  source = "./Modules/ec2_instance"
  image_name = var.ec2_web[count.index]["image_name"]
  owner = var.ec2_web[count.index]["owner"]
  subnet_id = module.subnet_web[count.index].id
  instance_size = var.ec2_web[count.index]["instance_size"]
  key_pair_id = module.ssh_key_a.id
  sg_list = [ module.security_group_web_a.sg_id ]
  tags_network_interface = merge({Name="${var.web_tags["Name"]}-nic-${count.index}"},local.tags)
  tags_ec2 = merge({Name="${var.web_tags["Name"]}-ec2-${count.index}"},local.tags)
  count = length(var.ec2_web)
}

#================================================X================================================#

################################
#Bastion ec2 declaration
################################
module "ec2_bastions" {
  source = "./Modules/ec2_instance"
  image_name = ["debian-12-amd64-20240717-1811"]
  owner = ["amazon"]
  subnet_id = module.subnet_bastion.id
  instance_size = "t2.micro"
  key_pair_id = module.ssh_key_a.id
  sg_list = [ module.security_group_bastion_a.sg_id ]
  tags_network_interface = merge({Name="${var.bastion_tags["Name"]}-nic"},local.tags)
  tags_ec2 = merge({Name="${var.bastion_tags["Name"]}-ec2"},local.tags)
}