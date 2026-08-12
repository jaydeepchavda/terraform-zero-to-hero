resource "aws_security_group" "alb" {
  name        = "${local.name_prefix}-alb-sg"
  description = "Security group for application load balancer"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTP from internet"

    from_port = 80
    to_port   = 80
    protocol  = "http"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS from internet"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-alb-sg"
    }
  )
}





resource "aws_lb" "app" {
    name = "${local.name_prefix}-alb"
    internal = false
    load_balancer_type = "application"

    security_groups = [ aws_security_group.alb.id ]

    subnets =[
        aws_subnet.app_a.id,
        aws_subnet.app_b.id
    ]

    tags = merge(
        local.common_tags,
        {
            Name = "${local.name_prefix}-alb"
        }
    )
}


resource "aws_lb_target_group" "app" {
    name = "${local.name_prefix}-tg"
    port = 80
    protocol = "http"

    vpc_id  = aws_vpc.main.id

    target_type = "instance"

    health_check ={
        path = "/"
        protocol = "HTTP"
        port = "traffic-port"
    }

    tags = merge(
        local.common_tags,
        {
            Name = "${local.name_prefix}-tg"
        }
    )
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  subnet_id = aws_subnet.app_a.id

  vpc_security_group_ids = [
    aws_security_group.my_ec2.id
  ]

  key_name = var.key_name

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-app"
    }
  )
}
resource "aws_lb_target_group_attachment" "app" {
  target_group_arn = aws_lb_target_group.app.arn

  target_id = aws_instance.app.id

  port = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type = "forward"

    target_group_arn = aws_lb_target_group.app.arn
  }
}



resource "aws_subnet" "app_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.app_subnet_cidrs[0]
  availability_zone = "${var.aws_region}a"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-app-a"
    }
  )
}

resource "aws_subnet" "app_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.app_subnet_cidrs[1]
  availability_zone = "${var.aws_region}b"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-app-b"
    }
  )
}