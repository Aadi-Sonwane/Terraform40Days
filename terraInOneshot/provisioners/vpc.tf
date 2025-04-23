resource "aws_vpc" "MyVpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MyVpc"
  }
}

resource "aws_subnet" "MySubnet" {
  vpc_id                  = aws_vpc.MyVpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "MySubnet"
  }
}

resource "aws_internet_gateway" "MyGateway" {
  vpc_id = aws_vpc.MyVpc.id

  tags = {
    Name = "MyGateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.MyVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MyGateway.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.MySubnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "MySGPub" {
  name        = "MySGPub"
  description = "This is for public sg for https https with ssh"
  vpc_id      = aws_vpc.MyVpc.id

  ingress {
    description = "ssh"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  ingress {
    description = "https"

    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http"
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
