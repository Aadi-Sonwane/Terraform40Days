
# Add provider block
provider "aws" {
  region = "us-east-1"
}

# create vpc with onc public subnet

variable "cidr_block" {
  default = "10.0.0.0/16"
}

# create key pair

resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-terrakey"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "my_vpc"
  }
}

resource "aws_subnet" "pubsub" {
  cidr_block = "10.0.0.0/24"
  vpc_id     = aws_vpc.my_vpc.id

  tags = {
    Name = "pubsub_subnet"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my_igw"
  }
}

resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "my_rt"
  }
}

resource "aws_route_table_association" "my_rt_association" {
  subnet_id      = aws_subnet.pubsub.id
  route_table_id = aws_route_table.my_rt.id
}

# create Security Group

resource "aws_security_group" "My_sg" {
  vpc_id = aws_vpc.my_vpc.id
  name   = "My_sg"
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "My_sg"
  }

}

# create EC2 instance

resource "aws_instance" "MyInstance" {
  ami                    = "" # Replace with a valid AMI ID for us-east-1 (e.g., for Ubuntu 20.04: "ami-0c55b159cbfafe1f0")
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.My_sg.id]
  subnet_id              = aws_subnet.pubsub.id
  tags = {
    name = "MyInstance"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip # Use public_ip after instance creation
  }

  # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "app.py" # Replace with the path to your local file
    destination = "/home/ubuntu/app.py" # Replace with the path on the remote instance
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y", # Update package lists (for ubuntu)
      "sudo apt-get install -y python3-pip", # Example package installation
      "cd /home/ubuntu",
      "sudo pip3 install flask",
      "sudo python3 app.py &",
    ]
  }
}



