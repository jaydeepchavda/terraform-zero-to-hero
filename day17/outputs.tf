output "servers" {

  value = {

    for name, server in aws_instance.server :

    name => {

      instance_id = server.id

      public_ip = server.public_ip

      private_ip = server.private_ip

      availability_zone = server.availability_zone

      instance_type = server.instance_type

      security_group = aws_security_group.server_sg[name].name

    }

  }

}