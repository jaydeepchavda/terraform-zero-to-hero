resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-vpc"
    }
  )
}

resource "aws_subnet" "db_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_subnet_cidrs[0]
  availability_zone = "${var.aws_region}a"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-db-a"
    }
  )
}

resource "aws_subnet" "db_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_subnet_cidrs[1]
  availability_zone = "${var.aws_region}b"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-db-b"
    }
  )
}


resource "aws_subnet" "app" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.aws_region}a"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-app"
    }
  )
}

resource "aws_security_group" "my_ec2" {
  name        = "${local.name_prefix}-ec2-sg"
  description = "Security group for application EC2"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-ec2-sg"
    }
  )
}


data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "app" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  subnet_id = aws_subnet.app.id

  vpc_security_group_ids = [
    aws_security_group.my_ec2.id
  ]

  key_name = var.key_name

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-app"
    }
  )
}