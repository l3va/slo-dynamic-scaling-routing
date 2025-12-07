resource "aws_appautoscaling_target" "ecs_nginx" {
  max_capacity       = var.ecs_max_capacity
  min_capacity       = var.ecs_min_capacity
  service_namespace  = "ecs"
  scalable_dimension = "ecs:service:DesiredCount"

  resource_id = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.nginx.name}"
}

resource "aws_appautoscaling_policy" "ecs_nginx_cpu_policy" {
  name               = "${var.project_name}-nginx-cpu-policy"
  policy_type        = "TargetTrackingScaling"
  service_namespace  = aws_appautoscaling_target.ecs_nginx.service_namespace
  scalable_dimension = aws_appautoscaling_target.ecs_nginx.scalable_dimension
  resource_id        = aws_appautoscaling_target.ecs_nginx.resource_id

  target_tracking_scaling_policy_configuration {
    target_value = 5  

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    scale_in_cooldown  = 60  
    scale_out_cooldown = 60  
  }

  depends_on = [
    aws_ecs_service.nginx
  ]
}
