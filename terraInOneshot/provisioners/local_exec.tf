# resource "aws_instance" "localExec" {
#   ami = var.ami
#   instance_type = var.instance_type
#   tags = {
#     Name = "${local.env}-localExec"
#   }
#   provisioner "local-exec" {
#     command = "echo ${aws_instance.localExec.private_ip} >> private_ips.txt"
#   }
# }

