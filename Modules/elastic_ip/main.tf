resource "aws_eip" "nic" {
  instance = var.ec2_id
  domain   = "vpc"
  tags = var.tags_value
}