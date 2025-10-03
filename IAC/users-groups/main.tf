resource "aws_iam_user" "users" {
  for_each = toset(var.users)
  name     = each.value
  path     = "/${each.value}/${each.key}/"

}

resource "aws_iam_group" "groups" {
  name = "Developer"
  path = "/developer/"
}

resource "aws_iam_group_membership" "group_membership" {
  name  = "developers-membership"
  users = [for user in aws_iam_user.users : user.name]
  group = aws_iam_group.groups.name

}
