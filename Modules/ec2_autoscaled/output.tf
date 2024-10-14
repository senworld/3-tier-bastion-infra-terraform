output "ami_id" {
  value = data.aws_ami.ami.id
}

output "ec2_id" {
  value = aws_autoscaling_group.autoscale_group.id
}