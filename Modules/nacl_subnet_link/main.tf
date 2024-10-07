resource "aws_network_acl_association" "nacl_link" {
  network_acl_id = var.nacl_id
  subnet_id      = var.subnet_id
}