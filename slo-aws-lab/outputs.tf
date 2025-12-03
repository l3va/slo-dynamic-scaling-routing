output "alb_dns_name" {
  description = "Public URL of the ALB"
  value       = aws_lb.this.dns_name
}

output "monitoring_ec2_public_ip" {
  description = "Public IP of monitoring EC2"
  value       = aws_instance.monitoring.public_ip
}
