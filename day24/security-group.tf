resource "aws_security_group" "web" {
    name = "Jac-api-sg"
    description = "Security Group for API Server"
    vpc_id = var.vpc_id

    ingress {
        description = "SSH"
        from_port = "22"
        tO_part = "22"
        protocol = "tcp"
        cidr_blocks = [
            var.my_ip
        ]
    }
    ingress {
        description = "HTTPS"
        from_port = "443"
        tO_part = "443"
        protocol = "https"
        cidr_blocks = [
            var.my_ip
        ]
    }
    ingress {
        description = "HTTP"
        from_port = "80"
        tO_part = "80"
        protocol = "http"
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    }
    egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  tags = {

    Name = "jac-api-sg"

  }

} 
resource "aws_security_group" "sg-web"{
    name = "jac-sql-sg"
    description = "security group for database api"
    vpc_id = var.id

    ingress {
        from_port = "sql"
        from_port = "1433"
        to_port = "1433"
        protocol = "-1"
        cidr_block = [
            "10.0.0.0/16"
        ]

    }
    tags {
        Name = "jac-sql-sg"
    }

}