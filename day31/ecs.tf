resource "aws_ecs_cluster" "app" {
  name = "${local.name_prefix}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${local.name_prefix}-cluster"
  }
}


resource "aws_ecs_task_definition" "nginx" {
  family = "${local.name_prefix}-nginx"

  network_mode = "awsvpc"

  requires_compatibilities = [
    "FARGATE"
  ]

  cpu    = "256"
  memory = "512"

  execution_role_arn = aws_iam_role.ecs_execution.arn

  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx:latest"
      essential = true

      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "nginx"
        }
      }
    }
  ])

  tags = {
    Name = "${local.name_prefix}-task-definition"
  }
}



resource "aws_ecs_service" "app" {
  name = "${local.name_prefix}-service"

  cluster = aws_ecs_cluster.app.id

  task_definition = aws_ecs_task_definition.nginx.arn

  desired_count = 2

  launch_type = "FARGATE"

  platform_version = "LATEST"

  health_check_grace_period_seconds = 60

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  network_configuration {
    subnets = [
      for subnet in aws_subnet.private : subnet.id
    ]

    security_groups = [
      aws_security_group.ecs.id
    ]

    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn

    container_name = "nginx"

    container_port = 80
  }

  depends_on = [
    aws_iam_role_policy_attachment.ecs_execution,
    aws_lb_listener.http
  ]

  tags = {
    Name = "${local.name_prefix}-service"
  }
}