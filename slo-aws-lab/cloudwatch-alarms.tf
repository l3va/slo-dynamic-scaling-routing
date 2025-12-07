resource "aws_cloudwatch_metric_alarm" "alb_latency_high" {
  alarm_name          = "${var.project_name}-alb-latency-high"
  alarm_description   = "ALB TargetResponseTime is too high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  datapoints_to_alarm = 2
  threshold           = 0.04

  metric_name = "TargetResponseTime"
  namespace   = "AWS/ApplicationELB"
  statistic   = "Average"
  period      = 60

  dimensions = {
    LoadBalancer = aws_lb.this.arn_suffix
  }

  treat_missing_data = "notBreaching"

  alarm_actions = []
  ok_actions    = []

  tags = {
    Project = var.project_name
  }
}

resource "aws_cloudwatch_metric_alarm" "alb_5xx_high" {
  alarm_name          = "${var.project_name}-alb-5xx-high"
  alarm_description   = "ALB returns too many 5XX responses"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  threshold           = 0

  metric_name = "HTTPCode_Target_5XX_Count"
  namespace   = "AWS/ApplicationELB"
  statistic   = "Sum"
  period      = 60

  dimensions = {
    LoadBalancer = aws_lb.this.arn_suffix
  }

  treat_missing_data = "notBreaching"

  alarm_actions = []
  ok_actions    = []

  tags = {
    Project = var.project_name
  }
}

