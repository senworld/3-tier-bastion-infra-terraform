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
  name = var.launch_template_name
  image_id      = data.aws_ami.ami.id
  instance_type = var.instance_size
  key_name  = var.key_pair_id
  user_data = var.user_data != null? var.user_data : null

  network_interfaces {
    associate_public_ip_address = var.is_public
    security_groups             = var.sg_list
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscale_group" {
  name = var.autoscale_group_name
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = 300
  health_check_type         = "EC2"
  vpc_zone_identifier = var.subnet_id
  target_group_arns   = var.target_group_arn
  launch_template {
    id      = aws_launch_template.ec2_template.id
    version = "$Latest"
  }

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  depends_on = [ aws_launch_template.ec2_template ]
}
