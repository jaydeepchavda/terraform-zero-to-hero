locals {
    origin_id =  "S3-${aws_s3_bucket.first_bucket.id}"
    mime_types = {
    html = "text/html"
    css  = "text/css"
    js   = "application/javascript"
    png  = "image/png"
    jpg  = "image/jpeg"
    jpeg = "image/jpeg"
    svg  = "image/svg+xml"
    json = "application/json"
    txt  = "text/plain"
  }
}