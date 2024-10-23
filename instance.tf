################################
#WebTier ec2 declaration
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
  ec2_name = "web"
  depends_on = [ module.nat_gateway_main,module.ec2_app_autoscaled ]
}

# ################################
# #AppTier ec2 declaration
# ################################
module "ec2_app_autoscaled" {
  source = "./Modules/ec2_autoscaled"
  image_name = var.ec2_app["image_name"]
  owner = var.ec2_app["owner"]
  subnet_id = local.app_subnets
  instance_size = var.ec2_app["instance_size"]
  key_pair_id = module.ssh_key_b.id
  is_public = false
  sg_list = [ module.security_group_app_a.sg_id ]
  max_size = 3
  min_size = 1
  desired_capacity = 2
  user_data = "${base64encode(data.template_file.ec2_web_userdata.rendered)}"
  launch_template_name = "ec2_app_template"
  autoscale_group_name = "ec2_app_autoscaled"
  ec2_name = "app"
  depends_on = [ module.nat_gateway_main,module.rds_db ]
}

################################
#DBTier RDS declaration
################################

module "rds_db" {
  source = "./Modules/rds"
  allocated_storage     = 10
  instance_class        = "db.t3.micro"
  db_name               = "db"
  username              = "admin"
  password              = random_password.db_password.result
  sg_list              = [module.security_group_db_a.sg_id]
  main_subnet_ids       = local.db_subnets
}

#================================================X================================================#

################################
#automation ec2 declaration
################################

module "ec2_automation" {
  source = "./Modules/ec2_instance"
  image_name = ["debian-12-amd64-20240717-1811"]
  owner = ["amazon"]
  subnet_id = local.automation_subnets[0]
  instance_size = "t2.micro"
  key_pair_id = module.ssh_key_b.id
  sg_list = [ module.security_group_automation.sg_id ]
  tags_network_interface = merge({Name="${var.automation_tags["Name"]}-nic"},local.tags)
  user_data = <<-EOF
              #!/bin/bash
              mkdir -p ~/.ssh
              echo "${module.ssh_key_gen_b.private_key}" > ~/.ssh/aws_key
              chmod 400 ~/.ssh/aws_key
              EOF
  tags_ec2 = merge({Name="${var.automation_tags["Name"]}-ec2"},local.tags)
  # depends_on = [ module.ec2_app_autoscaled ]
}


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