output "ami_id" {
  value = data.aws_ami.ami.id
}

output "ec2_id" {
  value = aws_instance.ec2.id
}