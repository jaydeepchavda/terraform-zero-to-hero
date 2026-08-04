output "instance_id" {

  value = aws_instance.web_server.id

}

output "availability_zone" {

  value = aws_instance.web_server.availability_zone

}

output "root_volume_id" {

  value = aws_instance.web_server.root_block_device[0].volume_id

}

output "extra_volume_id" {

  value = aws_ebs_volume.logs_volume.id

}