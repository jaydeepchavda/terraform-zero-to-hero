output "bucket_names" {
  value = {
    for name, bucket in aws_s3_bucket.jac_bucket :
    name => bucket.bucket

  }
}

output "bucket_arns" {
  value = {
    for name, bucket in aws_s3_bucket.jac_bucket :
    name => bucket.arn

  }
}