resource "aws_instance" "web_server" {

  ami = data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  tags = merge(

    local.common_tags,

    {

      Name = var.instance_name

    }

  )

  root_block_device {

    volume_size = var.root_volume_size

    volume_type = "gp3"

    encrypted = true

    delete_on_termination = true

  }

}


resource "aws_ebs_volume" "logs_volume" {

  availability_zone = aws_instance.web_server.availability_zone

  size = var.data_volume_size

  type = "gp3"

  encrypted = true

  tags = merge(

    local.common_tags,

    {

      Name = var.storage_name

      Purpose = "Application Logs"

    }

  )

}


resource "aws_volume_attachment" "logs_attachment" {

  device_name = "/dev/sdf"

  volume_id = aws_ebs_volume.logs_volume.id

  instance_id = aws_instance.web_server.id

}