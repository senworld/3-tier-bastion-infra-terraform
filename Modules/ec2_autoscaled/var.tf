variable "owner" {
  type = list(string)
}

variable "image_name" {
  type = list(string)
}

variable "instance_size" {
  type = string
}

variable "key_pair_id" {
  type = string
}

variable "sg_list" {
  type = list(string)
}

variable "is_public" {
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

variable "subnet_id" {
  type = list(string)
}

variable "user_data" {
  type = string
}

variable "target_group_arn" {
  type = set(string)
}

variable "autoscale_group_name" {
  type = string
}

variable "launch_template_name" {
  type = string
}