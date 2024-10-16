variable "tags" {
    type = map(string)
}

variable "vpc_id" {
    type = string
}

variable "subnet_id" {
  type = list(string)
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