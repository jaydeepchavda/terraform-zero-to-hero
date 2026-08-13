data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  subnet_id = aws_subnet.app_a.id

  vpc_security_group_ids = [
    aws_security_group.my_ec2.id
  ]

  key_name = var.key_name

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-app"
    }
  )
}


resource "aws_sns_topic" "alerts" {
  name = "${var.name_prefix}-alerts"

  tags= merge(
    local.common_tags
    {
      Name = "${local.name_prefix}-alerts"
    }
  )
}


resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn

  protocol = "email"

  endpoint = var.alarm_email
}


resource "aws_cloudwatch_metric_alarm" "ec2_high_cpu" {
  alarm_name = "${local.name_prefix}-ec2-high-cpu"

  alarm_description = "Alarm when EC2 CPU utilization is above 80%"

  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"

  dimensions = {
    InstanceId = aws_instance.app.id
  }

  statistic = "Average"

  period = 300

  evaluation_periods = 1

  threshold = 80

  comparison_operator = "GreaterThanThreshold"

  treat_missing_data = "notBreaching"

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-ec2-high-cpu"
    }
  )
}


output "ec2_instance_id" {
  description = "Application EC2 instance ID"
  value       = aws_instance.app.id
}

output "cloudwatch_alarm_name" {
  description = "CloudWatch CPU alarm name"
  value       = aws_cloudwatch_metric_alarm.ec2_high_cpu.alarm_name
}

output "sns_topic_arn" {
  description = "SNS alerts topic ARN"
  value       = aws_sns_topic.alerts.arn
}