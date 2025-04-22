provider "aws" {
  region = "us-east-1"
}

variable "instance_type" {
  description = "This is just instace type "
  type = string
  default = "t2.micro"
}

variable "ami" {
  description = "The value of ami of ubuntu"
  type = string
  default = "ami-084568db4383264d4"
}

locals {
  env = "dev"
}

resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.env}-vpc"
  }
}

resource "aws_subnet" "dev-subnet" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "${local.env}-subnet"
  }
}

resource "aws_instance" "dev-instance" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.dev-subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "${local.env}-instance"
  }
}