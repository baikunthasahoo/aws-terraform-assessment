
output "iam_users" {
  description = "Created IAM users"

  value = [
    aws_iam_user.engine.name,
    aws_iam_user.ci.name,
    aws_iam_user.developer1.name,
    aws_iam_user.developer2.name
  ]
}

output "iam_groups" {
  description = "Created IAM groups"

  value = [
    aws_iam_group.group1.name,
    aws_iam_group.group2.name
  ]
}

output "iam_roles" {
  description = "Created IAM roles"

  value = [
    aws_iam_role.roleA.name,
    aws_iam_role.roleB.name
  ]
}