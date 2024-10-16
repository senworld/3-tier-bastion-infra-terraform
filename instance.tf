################################
#Web ec2 declaration
################################
module "ec2_web_autoscaled" {
  source = "./Modules/ec2_autoscaled"
  image_name = var.ec2_web["image_name"]
  owner = var.ec2_web["owner"]
  subnet_id = local.web_subnets
  instance_size = var.ec2_web["instance_size"]
  key_pair_id = module.ssh_key_b.id
  is_public = false
  sg_list = [ module.security_group_web_a.sg_id ]
  max_size = 3
  min_size = 1
  desired_capacity = 2
  target_group_arn = toset([module.target_group_web.arn])
  user_data = "${base64encode(data.template_file.ec2_web_userdata.rendered)}"
  launch_template_name = "ec2_web_template"
  autoscale_group_name = "ec2_web_autoscaled"
  depends_on = [ module.nat_gateway_main ]
}

# module "ec2_web_test" {
#   source = "./Modules/ec2_instance"
#   image_name = var.ec2_web["image_name"]
#   owner = var.ec2_web["owner"]
#   subnet_id = module.subnet_web[0].id
#   instance_size = var.ec2_web["instance_size"]
#   key_pair_id = module.ssh_key_b.id
#   sg_list = [ module.security_group_web_a.sg_id ]
#   user_data = "${base64encode(data.template_file.ec2_web_userdata.rendered)}"
#   tags_ec2 = merge(var.web_tags,local.tags)
#   tags_network_interface = merge(var.web_tags,local.tags)
# }

#================================================X================================================#

################################
#Bastion ec2 declaration
################################

module "ec2_bastions" {
  source = "./Modules/ec2_instance"
  image_name = ["debian-12-amd64-20240717-1811"]
  owner = ["amazon"]
  subnet_id = local.bastion_subnets[0]
  instance_size = "t2.micro"
  key_pair_id = module.ssh_key_a.id
  sg_list = [ module.security_group_bastion_a.sg_id ]
  tags_network_interface = merge({Name="${var.bastion_tags["Name"]}-nic"},local.tags)
  user_data = <<-EOF
              #!/bin/bash
              mkdir -p ~/.ssh
              echo "${module.ssh_key_gen_b.private_key}" > ~/.ssh/aws_key
              chmod 400 ~/.ssh/aws_key
              EOF
  tags_ec2 = merge({Name="${var.bastion_tags["Name"]}-ec2"},local.tags)
}