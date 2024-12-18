# Create S3 bucket - basic
resource "aws_s3_bucket" "basic" {
  bucket = var.basic_bucket_name

  tags = {
    Name        = var.basic_bucket_name
    Environment = var.environment
  }
}

data "aws_iam_policy_document" "allow_access_from_cf_oac" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.basic.arn,
      "${aws_s3_bucket.basic.arn}/*",
    ]
    
    condition {
      test = "StringEquals"
      variable = "AWS:SourceArn"
      values = [aws_cloudfront_distribution.s3_oac.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_cf_oac" {
  bucket = aws_s3_bucket.basic.id
  policy = data.aws_iam_policy_document.allow_access_from_cf_oac.json
}