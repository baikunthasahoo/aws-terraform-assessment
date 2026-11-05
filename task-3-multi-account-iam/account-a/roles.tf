
# Role A: Administrative role except IAM
resource "aws_iam_role" "roleA" {
  name = "roleA"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        AWS = "arn:aws:iam::000000000000:root"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

# Role B: Cross-account access role
resource "aws_iam_role" "roleB" {
  name = "roleB"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        AWS = "arn:aws:iam::000000000000:root"
      }

      Action = "sts:AssumeRole"
    }]
  })
}
