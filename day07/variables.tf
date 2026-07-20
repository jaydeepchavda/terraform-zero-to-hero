variable "environment" {
  type    = string
  default = "Dev"
}

variable "username" {
  type    = string
  default = "jaydeep"
}

# variable "version" {
#   type    = string
#   default = "v1"
# }

variable "instance_count" {
  description = "number of ec2 instances to create"
  type        = number
  
}