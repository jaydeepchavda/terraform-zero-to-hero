resource "aws_security_group" "web" {

  name = "jac-web-sg"


ingress {

  from_port = 80

  to_port = 80

  protocol = "tcp"

  cidr_blocks = ["0.0.0.0/0"]

}
ingress {

  from_port = 22

  to_port = 22

  protocol = "tcp"

  cidr_blocks = [var.my_ip]

}
}

resource "aws_iam_instance_profile" "profile" {

}