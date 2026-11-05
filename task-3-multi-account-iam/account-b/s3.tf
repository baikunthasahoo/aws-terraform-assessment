
# Create the S3 bucket in Account B
resource "aws_s3_bucket" "assessment" {
  bucket = "my-cross-account-assessment-bucket-unique"

  tags = {
    Name        = "cross-account-assessment"
    Environment = "assessment"
    Owner       = "terraform"
  }
}

# Enable bucket versioning
resource "aws_s3_bucket_versioning" "assessment" {
  bucket = aws_s3_bucket.assessment.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "assessment" {
  bucket = aws_s3_bucket.assessment.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
