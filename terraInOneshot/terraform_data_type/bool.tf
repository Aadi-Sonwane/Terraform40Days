variable "enable_public_ip" {
  description = "Enable Public Ip"
  type = bool
  default = true
}

resource "aws_instance" "MyBool" {
  ami = var.ami
  instance_type = var.instance_type
  associate_public_ip_address = var.enable_public_ip
}