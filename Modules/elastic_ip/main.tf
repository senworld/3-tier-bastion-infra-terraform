resource "aws_eip" "eip" {
  instance = var.ec2_id
  domain   = "vpc"
  tags = var.tags_value
}