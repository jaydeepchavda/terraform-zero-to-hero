
data "aws_vpc" "existing" {

  filter {

    name = "tag:Name"

    values = ["production-vpc"]

  }

}

data "aws_subnet" "public" {

  filter {

    name = "tag:Name"

    values = ["public-subnet-1"]

  }

}

data "aws_security_group" "web" {

  filter {

    name = "group-name"

    values = ["web-sg"]

  }

}

data "aws_ami" "ubuntu" {

  most_recent = true

  owners = ["099720109477"]

  filter {

    name = "name"

    values = [

      "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"

    ]

  }

}