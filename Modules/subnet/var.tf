variable "vpc_id" {
    type = string
}

variable "cidr_range" {
    type = string
}

variable "subnet_az" {
    type = string
}

variable "tags_value" {
    type = map(string)
}

variable "is_public" {
  type = bool
  default = false
}