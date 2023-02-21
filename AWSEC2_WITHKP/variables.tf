variable "aws_region" {
    type    = string
    default = "us-east-1"
}

variable "aws_access_key" {
    default = "AKIA5DWRIW4SKFBWERUB"
}

variable "aws_secret_key" {
    default = "4r0LsR+on46m8AXpAbyR68F5kLX/rppXnoGqHg+i"
}

variable "aws_ami" {
    default = "ami-0557a15b87f6559cf"
}

variable  "aws_instance_type" {
    default = "t2.micro"
}

# variable = "aws_availability_zone" {
#     type = string
#     default = ""
# }

# variable = "TF_key_pair" {
#     type = string
#     default = "TF_key_pair"
# }