resource "tls_private_key" "key_gen" {
  algorithm = "RSA"
  rsa_bits  = 4096
}