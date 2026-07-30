output "bucket_names" {
   value = { for name,  bucket in aws_s3_bucket.company_bucket :
      name => bucket.bucket
  }
}

