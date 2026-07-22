environment = "dev"

project = "terraform"

owner = "jaydeep"

servers = {
  web      = "t3.micro"
  api      = "t3.small"
  database = "t3.large"
}

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnets = [
  "10.0.10.0/24",
  "10.0.11.0/24"
]