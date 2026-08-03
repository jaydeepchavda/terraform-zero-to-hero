resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true

  enable_dns_support = true

  tags = merge(

    local.common_tags,

    {

      Name = "${var.company}-${var.environment}-vpc"

    }

  )

}



resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id

  tags = merge(

    local.common_tags,

    {

      Name = "jac-igw"

    }

  )

}


resource "aws_subnet" "public" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.public_subnet_cidr

  availability_zone = "ap-south-1a"

  map_public_ip_on_launch = true

  tags = merge(

    local.common_tags,

    {

      Name = "public-subnet"

    }

  )

}


resource "aws_subnet" "private" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.private_subnet_cidr

  availability_zone = "ap-south-1a"

  tags = merge(

    local.common_tags,

    {

      Name = "private-subnet"

    }

  )

}