
# Role C: Cross-account S3 access
resource "aws_iam_role" "roleC" {
  name = "roleC"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        AWS = "arn:aws:iam::000000000000:role/roleB"
      }

      Action = "sts:AssumeRole"
    }]
  })
}
