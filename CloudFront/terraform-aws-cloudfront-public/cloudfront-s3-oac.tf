# Create CloudFront OAC policy
resource "aws_cloudfront_origin_access_control" "s3_oac" {
  name                              = "s3_oac"
  description                       = "S3 Origin OAC Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"

}

# Create CloudFront distrbution with OAC and S3 origin
locals {
  s3_oac_origin_id = "myS3OriginOAC"
}

resource "aws_cloudfront_distribution" "s3_oac" {
  origin {
    origin_access_control_id = aws_cloudfront_origin_access_control.s3_oac.id
    domain_name              = aws_s3_bucket.basic.bucket_regional_domain_name
    origin_id                = local.s3_oac_origin_id
  }

  enabled         = true
  is_ipv6_enabled = false
  comment         = "S3 Origin with OAC"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_oac_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}