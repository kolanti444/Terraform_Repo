provider "aws" {
	region     = "${var.aws_region}"
}

resource "aws_vpc" "myfirstVPC" {
	cidr_block = "${var.vpc_cidr}"
	enable_dns_hostnames = true
	tags = {
		name = "${var.vpc_name}"
	}
}

resource "aws_subnet" "publicsubnet1" {
	cidr_block = "${var.public_subnet1_cidr}"
	vpc_id = "${aws_vpc.myfirstVPC.id}"
	availability_zone = "us-east-1a"
	
	tags = {
		name = "${var.public_subnet1_name}"
	}
}

resource "aws_subnet" "publicsubnet2" {
	cidr_block = "${var.public_subnet2_cidr}"
	vpc_id = "${aws_vpc.myfirstVPC.id}"
	availability_zone = "us-east-1b"
	
	tags = {
		name = "${var.public_subnet2_name}"
	}
}

resource "aws_subnet" "privatesubnet1" {
	cidr_block = "${var.private_subnet1_cidr}"
	vpc_id = "${aws_vpc.myfirstVPC.id}"
	availability_zone = "us-east-1c"
	
	tags = {
		name = "${var.private_subnet1_name}"
	}
}
resource "aws_subnet" "privatesubnet2" {
	cidr_block = "${var.private_subnet2_cidr}"
	vpc_id = "${aws_vpc.myfirstVPC.id}"
	availability_zone = "us-east-1e"
	
	
	tags = {
		name = "${var.private_subnet2_name}"
	}
}

resource "aws_internet_gateway" "default"{
	vpc_id = "${aws_vpc.myfirstVPC.id}"
	tags = {
		name = "${var.IGW_name}"
	}
}
