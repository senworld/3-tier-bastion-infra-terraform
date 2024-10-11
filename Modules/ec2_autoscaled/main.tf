data "aws_ami" "ami" {
  most_recent = true
  filter {
    name   = "name"
    values = var.image_name
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = var.owner
}

resource "aws_launch_template" "ec2_template" {
  image_id      = aws_ami.ami.id
  instance_type = var.instance_size
  key_name  = var.key_pair_id
#   user_data = filebase64("${path.module}/ec2-init.sh")

  network_interfaces {
    associate_public_ip_address = var.is_ip_public
    security_groups             = var.sg_list
  }

  tag_specifications {
    resource_type = "instance"
    tags          = var.tags_value
  }
}

resource "aws_autoscaling_group" "autoscale_group" {
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = 300
  health_check_type         = var.health_check_type #"ELB" or default EC2
  vpc_zone_identifier = var.subnet_id
  target_group_arns   = [module.aws_lb.lb_tg_arn] #var.target_group_arns

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  launch_template {
    id      = aws_launch_template.ec2_template.id
    version = aws_launch_template.ec2_template.latest_version
  }
#   depends_on = [module.aws_lb]
}
