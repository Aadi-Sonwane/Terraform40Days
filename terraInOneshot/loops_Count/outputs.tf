
output "Multiple_user" {
  value = [for user_names in aws_iam_user.MyUser : user_names.name]
}

output "Arn" {
  value = [for user_names in aws_iam_user.MyUser : user_names.arn]
}

# output "for_each_user" {
#   value = [for for_each_user in aws_iam_user.user : each_ ]
# }


output "iam_user_names" {
  value = {
    for user_key, users in aws_iam_user.users :
    user_key => users.name
  }
}
 