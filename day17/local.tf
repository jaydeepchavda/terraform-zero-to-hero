locals {

  common_tags = {

    Company     = var.company
    Environment = var.environment
    Project     = var.project

  }

  servers = {

    bastion = {

      instance_type = "t3.micro"

      volume_size = 20

      monitoring = true

      description = "Bastion Server"

      ports = [22]

    }

    web = {

      instance_type = "t3.small"

      volume_size = 30

      monitoring = true

      description = "Web Server"

      ports = [80,443]

    }

    monitoring = {

      instance_type = "t3.medium"

      volume_size = 50

      monitoring = false

      description = "Monitoring Server"

      ports = [22,3000,9090]

    }

  }

}