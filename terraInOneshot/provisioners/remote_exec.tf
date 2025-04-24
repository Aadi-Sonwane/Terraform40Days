resource "aws_instance" "remoteExec" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = "aws_key"
  tags = {
    Name = "remoteExec"
  }
  vpc_security_group_ids = [aws_security_group.MySGPub.id]
  subnet_id              = aws_subnet.MySubnet.id

 provisioner "file" {
    source      = "./install-docker.sh"
    destination = "/tmp/install-docker.sh"
  }
  provisioner "remote-exec" {
    inline = [
        "touch demo.txt",
        "echo new file is creted >> demo.txt",
        "chmod +x /tmp/install-docker.sh",
        "sudo /tmp/install-docker.sh"
    ]
  }
  connection {
    host        = self.public_ip
    user        = "ubuntu"
    timeout     = "4m"
    private_key = file("./aws_key")
    type        = "ssh"

  }


 
}

output "ssh_command" {
  value = "ssh -i aws_key ubuntu@${aws_instance.remoteExec.public_ip}"
  description = "SSH command to connect to the EC2 instance"
}
