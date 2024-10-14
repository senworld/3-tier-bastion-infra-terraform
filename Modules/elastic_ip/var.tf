variable "ec2_id" {
  type = string
  default = null
}

variable "tags_value" {
  type = map(string)
  default = {}
}