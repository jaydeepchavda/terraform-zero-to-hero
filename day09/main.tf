locals {

  # String Functions

  environment_upper = upper(var.environment)

  project_lower = lower(var.project)

  title_name = title("${var.environment} environment")

  replaced_name = replace("dev-backend", "dev", "prod")

  formatted_name = format(
    "%s-%s-v1",
    var.environment,
    var.project
  )

  joined_name = join(
    "-",
    [
      var.environment,
      var.project,
      "backend"
    ]
  )

  split_name = split(
    "-",
    local.joined_name
  )

  trimmed_name = trim(
    "   terraform   ",
    " "
  )

  # Collection Functions

  total_public_subnets = length(var.public_subnets)

  all_subnets = concat(
    var.public_subnets,
    var.private_subnets
  )

  duplicate_servers = [
    "web",
    "web",
    "api",
    "database",
    "database"
  ]

  unique_servers = distinct(local.duplicate_servers)

  nested_list = [
    ["web", "api"],
    ["database"],
    ["redis", "rabbitmq"]
  ]

  flat_list = flatten(local.nested_list)

  contains_web = contains(
    local.flat_list,
    "web"
  )

  # Map Functions

  instance_type = lookup(
    var.servers,
    "web",
    "t2.micro"
  )

  server_names = keys(var.servers)

  server_types = values(var.servers)

  default_tags = {

    Environment = var.environment

    ManagedBy = "Terraform"

  }

  application_tags = {

    Owner = var.owner

    Project = var.project

  }

  merged_tags = merge(
    local.default_tags,
    local.application_tags
  )

  # File Functions

  userdata_file = file("${path.module}/userdata.sh")

  userdata_template = templatefile(
    "${path.module}/templates/userdata.tpl",
    {
      environment = var.environment
      project     = var.project
    }
  )

  userdata_base64 = base64encode(local.userdata_template)

  sample_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject"
        ]
        Resource = "*"
      }
    ]
  })

}