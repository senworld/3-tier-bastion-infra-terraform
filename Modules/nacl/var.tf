variable "vpc_id" {
  type = string
}

variable "tags_value" {
  type = map(string)
}

variable "egress_rule" {
  type = any
}

variable "ingress_rule" {
  type = any
}

variable "subnet_ids" {
  type = list(string)
}