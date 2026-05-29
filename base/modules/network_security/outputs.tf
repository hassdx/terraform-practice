output "security_group_id_ssh" {
  value = aws_security_group.ssh-inbound.id
}

output "security_group_id_lb_http" {
  value = aws_security_group.lb-http-inbound.id
}

output "security_group_id_http" {
  value = aws_security_group.http-inbound.id
}