variable "nacl_id" {
  type = string
}

variable "rule_number" {
  type = number
}

variable "egress" {
  type = bool
}

variable "protocol" {
  type = string
}

variable "action" {
  type = string
}

variable "cidr_range" {
  type = string
}

variable "from_port" {
  type = number
}

variable "to_port" {
  type = number
}