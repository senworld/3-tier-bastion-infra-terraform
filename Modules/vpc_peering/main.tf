resource "aws_vpc_peering_connection" "vpc_peer" {
  peer_vpc_id   = var.vpc_a_id
  vpc_id        = var.vpc_b_id
  auto_accept   = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = var.tags_value
}