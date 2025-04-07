output "public_ip_address" {
  value = aws_instance.ec2_ubuntu.public_ip
}