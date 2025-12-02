output "alb_dns_name" {
  description = "Public URL of the ALB"
  value       = aws_lb.this.dns_name
}
