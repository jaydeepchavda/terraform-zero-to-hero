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

variable "region" {
  type = string 
}

variable "monitoring_enabled" {
  type = bool
  default = true
}

variable "associate_public_ip" {
  type = bool
  default = true
}
 
variable "availability_zones" {

  type = list(string)

  default = ["ap-south-1a","ap-south-1b","ap-south-1c"]
}


variable "subnet_cidrs" {
  type = list(string)

  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}

