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
  type = list(object({
    destination_cidr_block = string
    gateway_id = string
    nat_gateway_id = string
    vpc_peering_connection_id = string
    vpc_endpoint_id = string
  }))
}