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



resource "aws_instance" "ec2-web-TF" {
ami               = var.aws_ami
instance_type     = var.aws_instance_type
# availability_zone = var.aws_availability_zone
key_name          = "TF_key_pair"

# network_interface {
# device_index         = 0
# network_interface_id = aws_network_interface.n-interface.id
# }

user_data = <<-EOF
#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo bash -c 'echo your very first web server > /var/www/html/index.html'
EOF

tags = {
Name = "first-ec2-server-TF"
}
}