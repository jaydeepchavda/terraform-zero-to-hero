output "bucket_name" {
  value = aws_s3_bucket.first_bucket.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.first_bucket.arn
}

output "cloudfront_domain" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}