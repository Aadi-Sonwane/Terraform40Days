# resource "aws_instance" "MyProbeInstance" {
#   ami                    = var.ami
#   instance_type          = var.instance_type
#   vpc_security_group_ids = [aws_security_group.MySGPub.id]
#   subnet_id = aws_subnet.MySubnet.id
#   key_name               = "aws_key"

#   provisioner "file" {
#     source      = "./demo.txt"
#     destination = "/home/ubuntu/demo.txt"
#   }
#   connection {
#     type        = "ssh"
#     host        = self.public_ip
#     user        = "ubuntu"
#     timeout     = "4m"
#     private_key = file("./aws_key")
#   }
#   tags = {
#     Name = "${local.env}-filePro"
#   }
# }

resource "aws_key_pair" "MyInstance" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDM/brJ56dK8PqgxpGfa3otYNg55Rr6u284JLU+Tk1ID+kB+p+XTqXni259fG9wQiY9jwEK70uEhd+rAk3B+MMp9PNwNv2ERqYVbFQ4rvwdovDiSZDiRgSHRiQB4J1r58wPg/xiXipqyZOFaC3iBul8W5/X7ET5/qJID6DG8sZIy6ZTvZiJwGHGKE6J5V5+l0Pv5eTxlMS6T/e8yalCQWTkdLvBfxgcFpvLrWNWBMWXDo7ywpJHgAe3YrdgTv5egqnLf4csjaX2F+7c+XHxJR2FBT11wef0oO4Wpc3YMHYetb5Sri45n1u3YTZ6y0jCZvIioL+frrSALNaChIdhr0/5 aditya@Aadi"
}
