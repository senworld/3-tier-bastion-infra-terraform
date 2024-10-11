variable "owner" {
  type = list(string)
}

variable "image_name" {
  type = list(string)
}

variable "tags_value" {
  type = map(string)
}

variable "instance_size" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "key_pair_id" {
  type = string
}

variable "sg_list" {
  type = list(string)
}

variable "is_ip_public" {
  type = bool
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}

variable "health_check_type" {
  type = string
}

variable "subnet_id" {
  type = list(string)
}

