locals {
  bucket_name = "${var.username}-bucket-${lower(var.environment)}-${var.version}"
  vpc_name    = "${var.environment}-VPC"
}