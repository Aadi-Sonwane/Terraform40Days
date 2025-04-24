# setup ec2 instance with open ingre for 80 nand 22 also install apache2 on server 

resource "aws_instance" "MyM1" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = "demokey"

    user_data = <<EOF
#!/bin/bash
# Update and install Apache
apt-get update -y
apt-get install -y apache2

# Start and enable Apache
systemctl start apache2
systemctl enable apache2

# Add a custom line to the index.html
echo "Apache is up and running - accessible over HTTP" >> /var/www/html/index.html

# Open port 80 in UFW if it's installed and active
if command -v ufw &> /dev/null; then
    ufw allow 'Apache'
    ufw reload
fi
EOF


tags = {
  Name = "MyM1Instance"
}
vpc_security_group_ids = [ aws_security_group.MyM1SG.id ]


}


resource "aws_security_group" "MyM1SG" {
  description = "mym1"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}