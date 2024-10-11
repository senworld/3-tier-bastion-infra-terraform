variable "target_port" {
  type = number
}

variable "protocol" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "tags_value" {
  type = map(string)
}

variable "ec2_id" {
  type = string
}

variable "listening_port" {
  type = number
}