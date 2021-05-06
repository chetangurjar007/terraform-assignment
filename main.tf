terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "/home/chetan/Downloads/project/.aws/credentials"
  
}


resource "aws_vpc" "new_vpc" {
  cidr_block       = "172.16.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
}

resource "aws_security_group" "new_security_g" {
  vpc_id      = "${aws_vpc.new_vpc.id}"
  name        = "terraform_new_private_sg"

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
  }

  egress {
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }
}


resource "aws_subnet" "terraform_new_subnet" {
  vpc_id     = "${aws_vpc.new_vpc.id}"
  cidr_block = "172.16.10.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_internet_gateway" "myigw" {
depends_on = [
    aws_subnet.terraform_new_subnet,
]
vpc_id = "${aws_vpc.new_vpc.id}"
}

resource "aws_route_table" "myrt" {
depends_on = [
    aws_internet_gateway.myigw,
]
vpc_id = "${aws_vpc.new_vpc.id}"
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.myigw.id}"
}

}
resource "aws_route_table_association" "a" {
depends_on = [
    aws_route_table.myrt,
]
subnet_id      = "${aws_subnet.terraform_new_subnet.id}"
route_table_id = aws_route_table.myrt.id
}

resource "aws_instance" "mynew" {
  ami           = "ami-0d5eff06f840b45e9"
  instance_type = "t2.micro"
  vpc_security_group_ids =  [ "${aws_security_group.new_security_g.id}" ]
  subnet_id = "${aws_subnet.terraform_new_subnet.id}"
  key_name               = "mynew"
  count         = 1
  associate_public_ip_address = true
}