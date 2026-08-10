


resource "aws_db_subnet_group" "main" {
  name = "${local.name_prefix}-db-subnet-group"

  subnet_ids = [
    aws_subnet.db_a.id,
    aws_subnet.db_b.id
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-db-subnet-group"
    }
  )
}


resource "aws_db_instance" "mysql" {
  identifier = "${local.name_prefix}-mysql"

  engine = "mysql"

  instance_class = var.db_instance_class

  allocated_storage = 20
  storage_type      = "gp3"

  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  port = local.db_port

  db_subnet_group_name = aws_db_subnet_group.main.name

  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  publicly_accessible = false

  backup_retention_period = 7

  skip_final_snapshot = true

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-mysql"
    }
  )
}