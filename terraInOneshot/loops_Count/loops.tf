variable "user_names" {
  description = "This is for count demo"
  type = list(string)
  default = [ "user1","user2", "user3" ]
}


resource "aws_instance" "MyCount" {
  ami = var.ami
  instance_type = var.instance_type
  count = 1
  tags = {
    Name = "${local.env}-Count"
  }
}


resource "aws_iam_user" "MyUser" {
  count = length(var.user_names)
  name = var.user_names[count.index]
}

