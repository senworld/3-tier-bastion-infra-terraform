module "vpc_a" {
  source = "./Modules/vpc"
  cidr_range = "192.168.0.0/16"
  tags_value = {
    Name = "vpc_a"
    Tier = "Main"
  }
}