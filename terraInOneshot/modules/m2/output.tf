output "MyM2Link" {
  value = "http://${aws_instance.MyM2.public_ip}"
}