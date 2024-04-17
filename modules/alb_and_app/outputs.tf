output "instance" {
    value = aws_instance.app
}

output "load_balancer_dns_name" {
  value = aws_lb.front_end.dns_name
}

output "app_instance_id" {
  value = aws_instance.app.id
}