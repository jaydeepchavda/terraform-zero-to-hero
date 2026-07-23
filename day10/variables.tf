variable "tags" {
  type = map(string)
  default = {
    Environment = "Dev"
    Name        = "dev-Instance"
    created_by  = "terraform"
    Compliance  = "yes"
  }
}

variable "instance_count" {
  type        = string
  description = "number of ec2 instance to count"
}

variable "environment" {
  type = string
}