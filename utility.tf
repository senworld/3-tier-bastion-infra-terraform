module "ssh_key_gen_a" {
  source = "./Modules/ssh_key_gen"
}

module "ssh_key_a" {
  source = "./Modules/key_pair"
  key_name = "bastion_key"
  public_key = module.ssh_key_gen_a.public_key
  tags_value = merge(var.bastion_tags,local.tags)
}

module "ssh_key_gen_b" {
  source = "./Modules/ssh_key_gen"
}

module "ssh_key_b" {
  source = "./Modules/key_pair"
  key_name = "application_key"
  public_key = module.ssh_key_gen_b.public_key
  tags_value = merge(var.root_tags,local.tags)
}