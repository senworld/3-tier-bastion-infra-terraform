resource "aws_route_table" "vps_routetable" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
  
  tags = {
    Name = "example"
  }
}