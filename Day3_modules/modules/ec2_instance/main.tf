resource "aws_instance" "ec2_ubuntu" {
  ami = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.tag_name
  }
}