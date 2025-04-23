resource "aws_instance" "MyOutput" {
  ami = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "${local.env}-Instance"
  }
}