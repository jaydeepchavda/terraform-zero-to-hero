locals {

  security_groups = {

    frontend = {

      description = "Frontend Application"

      ports = [80,443]

    }

    backend = {

      description = "Backend Application"

      ports = [8080]

    }

    monitoring = {

      description = "Monitoring Stack"

      ports = [3000,9090]

    }

  }

  common_tags = {

    Company     = var.company
    Environment = var.environment
    Project     = var.project

  }

}