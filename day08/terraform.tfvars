aws_region = "ap-south-1"

environment = "dev"

servers = {

  web      = "t3.micro"

  api      = "t3.small"

  jenkins  = "t3.medium"

}

volume_count = 2

volume_size = 20