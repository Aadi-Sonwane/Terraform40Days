
# multiple regio
provider "aws" {
  alias  = "east2"
  region = "us-east-2"
}
provider "aws" {
  alias  = "east1"
  region = "us-east-1"
}

resource "aws_instance" "east1_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  provider      = aws.east1
  key_name = var.key_name
  tags = {
    Name = "aws_instance_e1"
  }
}
resource "aws_instance" "east2_instance" {
  ami           = "ami-04f167a56786e4b09"
  instance_type = var.instance_type
  subnet_id = var.subnet_id_eu_2
  provider      = aws.east2
  key_name = var.key_name
  tags = {
    Name = "aws_instance_e2"
  }
}

