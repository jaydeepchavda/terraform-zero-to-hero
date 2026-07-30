output "security_groups" {

  value = {

    for name, sg in aws_security_group.application_sg :

    name => {

      id = sg.id

      name = sg.name

      arn = sg.arn

    }

  }

}