# resource "aws_vpc" "First_VPC" {
#   cidr_block       = "10.0.0.0/16"
#   instance_tenancy = "default"

#   tags = {
#     Name = "MyFirstVPC"
#   }
# }

# resource "aws_subnet" "Public_Subnet" {
#   vpc_id     = aws_vpc.First_VPC.id
#   cidr_block = "10.0.1.0/24"

#   tags = {
#     Name = "MyPublicSubnet"
#   }
# }

# resource "aws_subnet" "Private_Subnet" {
#   vpc_id     = aws_vpc.First_VPC.id
#   cidr_block = "10.0.1.0/24"

#   tags = {
#     Name = "MyPrivateSubnet"
#   }
# }


# resource "aws_internet_gateway" "FirstIGW" {
#   vpc_id = aws_vpc.First_VPC.id

#   tags = {
#     Name = "MyFirstIGW"
#   }
# }

# resource "aws_internet_gateway_attachment" "FirstIGW" {
#   internet_gateway_id = aws_internet_gateway.FirstIGW.id
#   vpc_id              = aws_vpc.First_VPC.id
# }



# resource "aws_route_table" "First_RT" {
#   vpc_id = aws_vpc.First_VPC.id

#   route {
#     cidr_block = "10.0.1.0/24"
#     gateway_id = aws_internet_gateway.FirstIGW.id
#   }

#   route {
#     ipv6_cidr_block        = "::/0"
#     egress_only_gateway_id = aws_egress_only_internet_gateway.FirstIGW.id
#   }

#   tags = {
#     Name = "MyfirstRoute"
#   }
# }

# resource "aws_route_table_association" "RTAssociation" {
#   subnet_id      = aws_subnet.Public_Subnet.id
#   route_table_id = aws_route_table.Private_Subnet.id
# }


# terraform {
#   backend "s3" {
#     bucket = "tf-state-bucket-20-02-2023"
#     key    = "app/preprod/terraform.tfstate"
#     region = "us-east-1"
#   }
# }




resource "aws_vpc" "First_VPC" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

    tags = {
      Name = "${var.name}"
   }
}

resource "aws_internet_gateway" "FirstIGW" {
  vpc_id = aws_vpc.First_VPC.id

  tags = {
    Name = "${var.IGW_Name}"
  }

}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.First_VPC.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = ""
  }
}


resource "aws_route_table" "public" {
    count = length(var.public_subnet_cidr_blocks)
    vpc_id = aws_vpc.First_VPC.id

}

resource "aws_route" "Public_Route" {
  count = length(var.public_subnet_cidr_blocks)
  route_table_id         = "aws_route_table.public[count.index].id"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.FirstIGW.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr_blocks)
  subnet_id      = "aws_subnet.public[count.index].id"
  route_table_id = "aws_route_table.public.id"
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_blocks)
  vpc_id            = aws_vpc.First_VPC.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]

}

resource "aws_route_table" "private" {
  count = length(var.private_subnet_cidr_blocks)
  vpc_id = aws_vpc.First_VPC.id

}

# resource "aws_route" "private" {
#   count = length(var.private_subnet_cidr_blocks)
#   route_table_id         = aws_route_table.private[count.index].id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.default[count.index].id
#}



resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr_blocks)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}



# resource "aws_vpc_endpoint" "s3" {
#   vpc_id       = aws_vpc.default.id
#   service_name = "com.amazonaws.${var.region}.s3"
#   route_table_ids = flatten([
#     aws_route_table.public.id,
#     aws_route_table.private.*.id
#   ])

# }

#
# NAT resources
#
# resource "aws_eip" "nat" {
#   count = length(var.public_subnet_cidr_blocks)

#   vpc = true
# }

# resource "aws_nat_gateway" "default" {
#   depends_on = [aws_internet_gateway.FirstIGW]

#   count = length(var.public_subnet_cidr_blocks)

#   allocation_id = aws_eip.nat[count.index].id
#   subnet_id     = aws_subnet.public[count.index].id

  # tags = merge(
  #   {
  #     Name        = "gwNAT",
  #     Project     = var.project,
  #     Environment = var.environment
  #   },
  #   var.tags
  # )
#}