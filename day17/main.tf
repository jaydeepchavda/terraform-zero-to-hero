resource "aws_security_group" "application_sg" {

  for_each = local.security_groups

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

      to_port = ingress.value

      protocol = "tcp"

      cidr_blocks = ["0.0.0.0/0"]

    }

  }

  egress {

    from_port = 0

    to_port = 0

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

      Application = title(each.key)

    }

  )

}