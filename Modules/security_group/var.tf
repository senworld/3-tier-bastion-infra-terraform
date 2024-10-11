variable "vpc_id" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "tags_value" {
  type = map(string)
}

variable "ingress_rule" {
  type = any
  default = null
}

variable "egress_rule" {
  type = any
  default = null
}