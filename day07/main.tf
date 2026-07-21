resource "aws_s3_bucket" "demo_bucket" {

  count = 1
  bucket = local.bucket_name

  tags = {
    Name        = "${var.environment}-Bucket"
    Environment = var.environment
  }
}

resource "aws_subnet" "public" {

  count = length(var.subnet_cidrs)

  vpc_id = aws_vpc.demo_vpc.id

  cidr_block = var.subnet_cidrs[count.index]
}

resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = local.vpc_name
    Environment = var.environment
  }
}

resource "aws_instance" "demo_ec2" {
  ami           = "ami-0f58b397bc5c1f2e8"   # Replace with a valid AMI for your region
  instance_type = "t2.micro"
  count         = var.instance_count
  region        = var.region

  monitoring   = var.monitoring_enabled
  associate_public_ip_address = var.associate_public_ip

  tags = {
    Name        = "${var.environment}-EC2"
    Environment = var.environment
  }
}