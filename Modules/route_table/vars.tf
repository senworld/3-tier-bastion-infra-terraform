variable "tags_value" {
    type = map(string)
}

variable "cidr_range" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "route" {
  type = any
}