
resource "aws_iam_user" "engine" {
  name = "engine"
}

resource "aws_iam_user" "ci" {
  name = "ci"
}

resource "aws_iam_user" "developer1" {
  name = "developer1"
}

resource "aws_iam_user" "developer2" {
  name = "developer2"
}
