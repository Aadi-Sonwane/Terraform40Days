variable "user_names" {
  description = "This is the list data type"
  type = list(string)
  default = [ "user1","user2", "user3" ]
}

resource "aws_instance" "MyList" {
  ami = var.ami
  instance_type = var.instance_type

}

resource "aws_iam_user" "MyUserList" {
  count = length(var.user_names)
  name = var.user_names[count.index]
}