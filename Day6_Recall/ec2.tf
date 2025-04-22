provider "aws" {
  region = "us-east-1"
}

#creating ec2 instance 

resource "aws_instance" "ec2_instace" {
  ami = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  tags = {
    name = "MyInstance"
  }
}