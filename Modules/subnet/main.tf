resource "aws_subnet" "subnet_1a" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone  = var.subnet_az

  tags = {
    Name = "subnet_1a"
    Tier = "web"
  }
}