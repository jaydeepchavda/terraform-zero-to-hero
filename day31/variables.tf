variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "project_name" {
  type    = string
  default = "ecs-demo"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type = list(string)

  default = [
    "ap-south-1a",
    "ap-south-1b"
  ]
}

variable "public_subnet_cidrs" {
  type = map(string)

  default = {
    "ap-south-1a" = "10.0.1.0/24"
    "ap-south-1b" = "10.0.2.0/24"
  }
}

variable "private_subnet_cidrs" {
  type = map(string)

  default = {
    "ap-south-1a" = "10.0.11.0/24"
    "ap-south-1b" = "10.0.12.0/24"
  }
}