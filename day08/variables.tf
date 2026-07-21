variable "aws_region" {

  type = string

}

variable "environment" {

  type = string

}

variable "servers" {

  type = map(string)

}

variable "volume_count" {

  type = number

}

variable "volume_size" {

  type = number

}