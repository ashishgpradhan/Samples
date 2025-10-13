resource "tls_private_key" "PrivateKey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "KeyPair" {
  key_name   = "my-key-pair"
  public_key = tls_private_key.PrivateKey.public_key_openssh

}

resource "local_file" "pem_file" {
  content  = tls_private_key.PrivateKey.private_key_pem
  filename = "${path.module}/terraform-key.pem"
}