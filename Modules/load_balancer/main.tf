resource "aws_lb" "alb" {
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.sg_list
  subnets            = var.subnet_list

  enable_deletion_protection = false

  tags = var.tags_value
}

resource "aws_lb_listener" "my_alb_listener" {
 load_balancer_arn = aws_lb.alb.arn
 port              = var.lb_listening_port
 protocol          = var.lb_protocol

 default_action {
    type = "forward"
    forward {
      dynamic "target_group" {
        for_each = var.target_groups
        content {
          arn = target_group.value
        }
      }
    } 
  }
}