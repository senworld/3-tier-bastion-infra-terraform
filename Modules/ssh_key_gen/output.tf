output "id" {
  value = tls_private_key.key_gen.id
}

output "private_key" {
  value = tls_private_key.key_gen.private_key_openssh
  sensitive = true
}

output "public_key" {
  value = tls_private_key.key_gen.public_key_openssh
}