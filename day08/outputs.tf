output "instance_ids" {

  value = {

    for name, server in aws_instance.servers :

    name => server.id

  }

}

output "private_ips" {

  value = {

    for name, server in aws_instance.servers :

    name => server.private_ip

  }

}

output "ebs_volume_ids" {

  value = aws_ebs_volume.extra_disk[*].id

}