# IMP to user for_each loop we need to user eithere set(string) or map(string). It does not have duplicate values

variable "user_set" {
  description = "list of users"
  type = set(string)
  default = ["Aditya","Nihar","Me"]
}

variable "user_map" {
  description = "list of roles"
  type = map(string)
  default = {
    DevOps = "DevOps",
    AWS = "AWS",
    Admin = "Admin",
    Admin = "Admin"
  }
}

resource "aws_iam_user" "user" {
  for_each = var.user_set
  name = each.value
}

resource "aws_iam_user" "users" {
  for_each = var.user_map
  name = each.value
  path = "/"
}
