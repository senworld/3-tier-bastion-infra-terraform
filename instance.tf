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

