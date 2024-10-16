variable "vpc_id" {
    type = string
}

variable "cidr_range" {
    type = string
}

variable "subnet_az" {
    type = string
}

variable "is_public" {
    type = string
}

variable "tags" {
    type = map(string)
}