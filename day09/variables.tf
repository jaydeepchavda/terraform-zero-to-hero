variable "environment" {
  type    = string
}

variable "project" {
  type    = string
}

variable "owner" {
  type    = string
}

variable "servers" {
  type = map(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}