resource "aws_security_group" "server_sg" {

  for_each = local.servers

  name = lower(
    format(
      "%s-%s-%s-%s-sg",
      var.company,
      var.environment,
      var.project,
      each.key
    )
  )

  description = each.value.description

  vpc_id = var.vpc_id

  dynamic "ingress" {

    for_each = each.value.ports

    content {

      from_port = ingress.value
      to_port   = ingress.value

      protocol = "tcp"

      cidr_blocks = ["0.0.0.0/0"]

    }

  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = merge(

    local.common_tags,

    {

      Name = lower(
        format(
          "%s-%s-%s-%s-sg",
          var.company,
          var.environment,
          var.project,
          each.key
        )
      )

    }

  )

  resource "aws_instance" "server" {

  for_each = local.servers

  ami = data.aws_ami.ubuntu.id

  instance_type = each.value.instance_type

  monitoring = each.value.monitoring

  vpc_security_group_ids = [

    aws_security_group.server_sg[each.key].id

  ]

  root_block_device {

    volume_size = each.value.volume_size

    volume_type = "gp3"

    encrypted = true

    delete_on_termination = true

  }

  tags = merge(

    local.common_tags,

    {

      Name = lower(
        format(
          "%s-%s-%s",
          var.environment,
          var.project,
          each.key
        )
      )

    }

  )

}
