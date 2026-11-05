
# Trust policy: Allow only roleB from Account A
data "aws_iam_policy_document" "roleC_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::000000000000:role/roleB"
      ]
    }
  }
}

# Create roleC in Account B
resource "aws_iam_role" "roleC" {
  name               = "roleC"
  assume_role_policy = data.aws_iam_policy_document.roleC_trust.json
}

# Give roleC access to one specific S3 bucket
resource "aws_iam_role_policy" "roleC_s3" {
  name = "roleC-s3-access"
  role = aws_iam_role.roleC.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Action = [
        "s3:*"
      ]

      Resource = [
        "arn:aws:s3:::my-cross-account-assessment-bucket-unique",
        "arn:aws:s3:::my-cross-account-assessment-bucket-unique/*"
      ]
    }]
  })
}
