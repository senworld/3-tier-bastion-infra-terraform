module "key" {
  source = "./Modules/key_pair"
  key_name = "application_key"
  public_key = local.public_key_value
  tags_value = {
    Name = "Application_key"
    Tier = "Main"
  }
}

module "ec2_webtier_1a" {
  source = "./Modules/ec2"
  image_name = ["debian-12-amd64-20240717-1811"]
  owner = ["amazon"]
  subnet_id = module.subnet_1a.id
  instance_size = "t2.micro"
  key_pair_id = module.key.id
  tags_ami_lookup = {
    Name = "webtier_1a"
    Tier = "Web"
  }
  tags_network_interface = {
    Name = "webtier_1a"
    Tier = "Web"
  }
  tags_ec2 = {
    Name = "webtier_1a"
    Tier = "Web"
  }
}

