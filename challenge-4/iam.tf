data "aws_iam_users" "users" {} 

data "aws_caller_identity" "current_user" {}

resource "aws_iam_user" "lb" {
  name = "admin-user-${data.aws_caller_identity.current_user.account_id}"
}

output "name" {
  value = data.aws_iam_users.users.names
}

output "total_users" {
  value = length(data.aws_iam_users.users.names)
}