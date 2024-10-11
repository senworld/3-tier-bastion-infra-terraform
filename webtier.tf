# module "security_group_web_a" {
#   source = "./Modules/security_group"
#   vpc_id = module.vpc_a.id
#   sg_name = "security_group_web_a"
#   tags_value = {
#     Name = "security_group_web_a"
#     Tier = "Web"
#   }
# }

# module "ingress_rule_a" {
#   source = "./Modules/sg_ingress"
#   sg_id = module.security_group_web_a.sg_id
#   cidr_range = "0.0.0.0/0"
#   protocol = "tcp"
#   from_port = "22"
#   to_port = "22"
# }

# module "egress_rule_a" {
#   source = "./Modules/sg_egress"
#   sg_id = module.security_group_web_a.sg_id
#   cidr_range = "0.0.0.0/0"
#   protocol = "-1"
#   from_port = "0"
#   to_port = "0"
# }

# module "ec2_web_a" {
#   source = "./Modules/ec2"
#   image_name = ["debian-12-amd64-20240717-1811"]
#   owner = ["amazon"]
#   subnet_id = module.subnet_web_a.id
#   instance_size = "t2.micro"
#   key_pair_id = module.ssh_key_a.id
#   sg_list = [ module.security_group_web_a.sg_id ]
#   tags_network_interface = {
#     Name = "nic_web_a"
#     Tier = "Web"
#   }
#   tags_ec2 = {
#     Name = "ec2_web_a"
#     Tier = "Web"
#   }
# }

