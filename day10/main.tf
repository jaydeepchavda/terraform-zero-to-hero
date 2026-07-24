resource "aws_instance" "example" {
  ami           = "ami-0912f71e06545ad88"
  count         = var.instance_count
  instance_type = var.environment == "dev" ? "t2.micro" : "t3.micro"
  tags          = var.tags
}


resource "aws_security_group" "ingress_rule" {
  name   = "sg"

  ingress  { 
    from_port = 80
    to_port   = 80
    protocol = "http"

    cidr_blocks = ["0.0.0.0/0"]
}
  egress  = []
}

# {""_-