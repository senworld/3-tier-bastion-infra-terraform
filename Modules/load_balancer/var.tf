variable "sg_list" {
  type = list(string)
}

variable "subnet_list" {
  type = list(string)
}

variable "tags_value" {
  type = map(string)
}

variable "lb_listening_port" {
  type = number
}

variable "lb_protocol" {
  type = string
}

variable "target_groups" {
  type = list(string)
}