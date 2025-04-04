provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "ec2_instance" {
  ami = "ami-04f167a56786e4b09"
  instance_type = "t2.micro"
  key_name = "terrakey"
  subnet_id = "subnet-0e1dac8c9305daf6f"
  tags = {
    Name = "Terratest"
  }
}