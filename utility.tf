module "ssh_key_a" {
  source = "./Modules/key_pair"
  key_name = "application_key"
  public_key = local.public_key_value
  tags_value = {
    Name = "ssh_key_a"
    Tier = "Main"
  }
}