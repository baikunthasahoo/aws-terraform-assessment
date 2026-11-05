
# Create group1 for CLI/programmatic users
resource "aws_iam_group" "group1" {
  name = "group1"
}

# Create group2 for console and CLI users
resource "aws_iam_group" "group2" {
  name = "group2"
}

# Add engine and ci to group1
resource "aws_iam_group_membership" "group1_members" {
  name = "group1-members"

  users = [
    aws_iam_user.engine.name,
    aws_iam_user.ci.name
  ]

  group = aws_iam_group.group1.name
}

# Add developer1 and developer2 to group2
resource "aws_iam_group_membership" "group2_members" {
  name = "group2-members"

  users = [
    aws_iam_user.developer1.name,
    aws_iam_user.developer2.name
  ]

  group = aws_iam_group.group2.name
}
    