resource "aws_instance" "example" {
  ami           = "ami-0912f71e06545ad88"
  count         = var.instance_count
  instance_type = var.environment == "dev" ? "t2.micro" : "t3.micro"
  tags          = var.tags
}




# {""_-