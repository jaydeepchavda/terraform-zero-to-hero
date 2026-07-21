output "vpc_id" {
  value = aws_vpc.demo_vpc.id
}

output "ec2_id" {
  value = aws_instance.demo_ec2.id
}

output "bucket_name" {
  value = aws_s3_bucket.demo_bucket.bucket
}


output "azs" {
  value = var.availability_zones
}