
# Give roleC full access to the assessment S3 bucket
resource "aws_iam_policy" "roleC_s3_policy" {
  name        = "roleC-s3-full-access"
  description = "Full access to the assessment S3 bucket only"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Action = "s3:*"

      Resource = [
        aws_s3_bucket.assessment.arn,
        "${aws_s3_bucket.assessment.arn}/*"
      ]
    }]
  })
}

# Attach the S3 policy to roleC
resource "aws_iam_role_policy_attachment" "roleC_s3_attachment" {
  role       = aws_iam_role.roleC.name
  policy_arn = aws_iam_policy.roleC_s3_policy.arn
}
