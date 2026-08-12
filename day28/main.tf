
resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  alarm_name = "${local.name_prefix}-ec2-high-cpu"

  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"

  dimensions = {
    InstanceId = aws_instance.app.id
  }

  statistic = "Average"
  period    = 300

  evaluation_periods  = 1
  threshold           = 80
  comparison_operator = "GreaterThanThreshold"

  alarm_description = "Alarm when EC2 CPU utilization exceeds 80%"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-ec2-high-cpu"
    }
  )
}