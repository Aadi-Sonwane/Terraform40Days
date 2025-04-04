output "public_ip" {
  description = "Public Ip address of instance"
  value       = aws_instance.east1_instance.public_ip
}

output "ip" {
  description = "Private Ip address of instance"
  value       = aws_instance.east2_instance.public_ip
}
