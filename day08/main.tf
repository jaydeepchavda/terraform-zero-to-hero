# EC2 Instances (for_each)


resource "aws_instance" "servers" {

  for_each = var.servers

  ami                    = data.aws_ami.ubuntu.id

  instance_type          = each.value

  subnet_id              = data.aws_subnet.public.id

  vpc_security_group_ids = [

    data.aws_security_group.web.id

  ]

  tags = {

    Name        = "${var.environment}-${each.key}"

    Environment = var.environment

    ManagedBy   = "Terraform"

  }

}

# EBS Volumes (count)

resource "aws_ebs_volume" "extra_disk" {

  count = var.volume_count

  availability_zone = aws_instance.servers["web"].availability_zone

  size = var.volume_size

  type = "gp3"

  tags = {

    Name = "${var.environment}-volume-${count.index + 1}"

  }

}

# Volume Attachment

resource "aws_volume_attachment" "attach" {

  count = var.volume_count

  device_name = "/dev/sdh${count.index}"

  volume_id = aws_ebs_volume.extra_disk[count.index].id

  instance_id = aws_instance.servers["web"].id

}