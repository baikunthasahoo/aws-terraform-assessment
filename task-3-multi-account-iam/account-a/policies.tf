
# Policy for roleA: Allow all AWS services except IAM
resource "aws_iam_policy" "roleA_policy" {
  name        = "roleA-admin-except-iam"
  description = "Administrative access to all AWS services except IAM"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect    = "Allow"
      NotAction = "iam:*"
      Resource  = "*"
    }]
  })
}

# Attach the policy to roleA
resource "aws_iam_role_policy_attachment" "roleA_attachment" {
  role       = aws_iam_role.roleA.name
  policy_arn = aws_iam_policy.roleA_policy.arn
}

# Policy for roleB: Allow assuming only roleC in Account B
resource "aws_iam_policy" "roleB_policy" {
  name        = "roleB-assume-roleC-only"
  description = "Allows roleB to assume only roleC in Account B"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Action = [
        "sts:AssumeRole"
      ]

      Resource = "arn:aws:iam::111111111111:role/roleC"
    }]
  })
}

# Attach the policy to roleB
resource "aws_iam_role_policy_attachment" "roleB_attachment" {
  role       = aws_iam_role.roleB.name
  policy_arn = aws_iam_policy.roleB_policy.arn
}
