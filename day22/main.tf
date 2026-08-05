resource "aws_s3_bucket" "jac_bucket" {
  for_each = local.bucket_perpose

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
      Name    = each.key
      Perpose = each.value.perpose
    }
  )
}


resource "aws_s3_bucket_versioning" "jac_bucket" {
  for_each = aws_s3_bucket.jac_bucket

  bucket = each.value.id

  versioning_configuration {
    status = "Enabled"
  }
}



resource "aws_s3_bucket_server_side_encryption_configuration" "jac_bucket" {

  for_each = aws_s3_bucket.jac_bucket

  bucket = each.value.id

  rule {

    apply_server_side_encryption_by_default {

      sse_algorithm = "AES256"

    }

  }

}


resource "aws_s3_bucket_public_access_block" "jac_bucket" {
  for_each = aws_s3_bucket.jac_bucket

  bucket = each.value.id

  block_public_acls = true

  block_public_policy = true

  ignore_public_acls = true

  restrict_public_buckets = true

}


resource "aws_s3_bucket_lifecycle_configuration" "jac_bucket" {

  for_each = aws_s3_bucket.jac_bucket

  bucket = each.value.id

  rule {

    id = "archive-old-files"

    status = "Enabled"

    filter {}

    transition {

      days = 365

      storage_class = "GLACIER"

    }

    expiration {

      days = 2555

    }

  }

}