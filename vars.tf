variable "aws_region" {
 type = string
 default = "ap-south-1"
}

locals {
  public_key_value = file("C:/Users/Sen/.ssh/awskey.pub")
}