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



variable "ingress_rules" {
  description = "List of ingress rules for security group"

  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
    cidr_blocks = list(string)
    description = string
  }))

  default = [
    {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP"
    },
    {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS"
    }
  ]
}