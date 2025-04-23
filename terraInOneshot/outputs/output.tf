output "public_ip" {
  description = "Taking the Ip of Ec2 Instance"
  value       = aws_instance.MyOutput.public_ip
}

output "private_ip" {
  description = "Taking the Ip of Ec2 Instance"
  value       = aws_instance.MyOutput.private_ip
}


output "Instance_id" {
  value = aws_instance.MyOutput.id
  sensitive = true
}