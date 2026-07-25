resource "aws_instance" "example" {
  ami           = "ami-0912f71e06545ad88"
  count         = var.instance_count
  instance_type = var.environment == "dev" ? "t2.micro" : "t3.micro"
  tags          = var.tags
}

# dynamic blocks example
resource "aws_security_group" "ingress_rule" {
  name   = "sg"

  dynamic "ingress"  { 
    for_each = var.ingress_rules
    content {
      from_port = ingress.value.from_port
      to_port   = ingress.value.to_port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
    
}
  egress  = []
}

# flat expressions

locals {
  all_instances_ids = aws_instance.example[*].id
}

output "instances" {
  value = local.all_instances_ids
}


# {""_-