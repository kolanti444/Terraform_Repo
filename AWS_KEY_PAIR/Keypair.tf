resource "aws_key_pair" "TF_key_pair" {
key_name = "TF_key_pair"
public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
algorithm = "RSA"
rsa_bits  = 4096
}

resource "local_file" "TF_key" {
content  = tls_private_key.rsa.private_key_pem
filename = "TF_key_pair"
}