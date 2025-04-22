provider "aws" {
  region = "us-east-1"
}


# terraform Input variables 

variable "ami" {
  description = "This is terraform ami image id"
  type = string
  default = "ami-084568db4383264d4"
}
variable "instance_type" {
  description = "This is terraform instance type"
  type = string
  default = "t2.micro"
}

# we use conunt data type

variable "instance_count" {
  description = "This is terraform instance count"
  type = number
  default = 0
}

# Calling input variables in resources 

resource "aws_instance" "MyInstance" {
  ami = var.ami
  instance_type = var.instance_type
  count = var.instance_count

  tags = {
    Name = "MyInstance"
  }
}