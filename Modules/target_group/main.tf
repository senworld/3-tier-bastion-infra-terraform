resource "aws_lb_target_group" "target_group" { // Target Group A
 port     = var.target_port
 protocol = var.protocol
 vpc_id   = var.vpc_id
 health_check {
    path = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold  = 2
    unhealthy_threshold = 2
    matcher             = "200"
    protocol            = "HTTP"
    port                = "traffic-port"
 }  
 tags = var.tags_value
}

# resource "aws_lb_target_group_attachment" "target_instance_link" {
#  target_group_arn = aws_lb_target_group.target_group.arn
#  target_id        = var.ec2_id
#  port             = var.listening_port
# }