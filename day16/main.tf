resource "aws_s3_bucket" "company_bucket" {

  for_each = local.bucket_purpose

  bucket = lower(
    format(
      "%s-%s-%s-%s",
      var.company,
      var.environment,
      var.project,
      each.key
    )
  )

  tags = merge(

    local.common_tags,

    {

      Purpose = each.value.purpose

    }

  )

}


resource "aws_s3_bucket_versioning" "company_bucket" {

  for_each = aws_s3_bucket.company_bucket

  bucket = each.value.id

  versioning_configuration {

    status = "Enabled"

  }

}


resource "aws_s3_bucket_server_side_encryption_configuration" "company_bucket" {

  for_each = aws_s3_bucket.company_bucket

  bucket = each.value.id

  rule {

    apply_server_side_encryption_by_default {

      sse_algorithm = "AES256"

    }

  }

}


resource "aws_s3_bucket_public_access_block" "company_bucket" {

  for_each = aws_s3_bucket.company_bucket

  bucket = each.value.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}