output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "alb_target_group_arn" {
  value       = aws_lb_target_group.this.arn
  description = "ARN do target group do ALB"
}

output "http_listener_arn" {
  value = aws_lb_listener.http.arn
}

output "alb_name" {
  value = aws_lb.this.name
}
