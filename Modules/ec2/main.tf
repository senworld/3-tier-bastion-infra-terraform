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

  tags = var.tags_ami_lookup
}

resource "aws_network_interface" "network_interface" {
  subnet_id   = var.subnet_id

  tags = var.tags_network_interface
}

resource "aws_instance" "ec2" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_size

  network_interface {
    network_interface_id = aws_network_interface.network_interface.id
    device_index         = 0
  }
  
  key_name = var.key_pair_id

  credit_specification {
    cpu_credits = "standard"
  }

  tags = var.tags_ec2
}