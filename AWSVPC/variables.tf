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

# variable "name" {
#   default     = "Default"
#   type        = string
#   description = "Name of the VPC"
# }

# variable "project" {
#   type        = string
#   description = "Name of project this VPC is meant to house"
# }

# variable "environment" {
#   type        = string
#   description = "Name of environment this VPC is targeting"
# }

variable "region" {
  default     = "us-east-1"
  type        = string
  description = "Region of the VPC"
}

variable "availability_zones" {
  default     = ["us-east-1a", "us-east-1b","us-east-1c"]
  type        = list(any)
  description = "List of availability zones"
}

variable "name" {
    type = string
    default = "MyFirstVPC"
}

variable "cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_blocks" {
  default     = ["10.0.0.0/24", "10.0.1.0/24","10.0.2.0/24"]
  type        = list(any)
  description = "List of public subnet CIDR blocks"
}

variable "private_subnet_cidr_blocks" {
  default     = ["10.0.10.0/24", "10.0.20.0/24","10.0.30.0/24"]
  type        = list(any)
  description = "List of private subnet CIDR blocks"
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "Extra tags to attach to the VPC resources"
}

variable "IGW_Name" {
   default = "First_IGW"
    
}
