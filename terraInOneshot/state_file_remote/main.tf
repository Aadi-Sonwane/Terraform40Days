terraform {
  backend "s3" {
    bucket         = "myterrastatecode"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"  # optional but recommended for locking
    //encrypt        = true
  }
}



resource "aws_instance" "MyStateInstance" {
  ami           = var.ami
  instance_type = var.instance_type
  count         = 2

  tags = {
    Name = "${local.env}-StateInstance-${count.index + 1}"
  }
}


output "instance_ids" {
  value = [for instance in aws_instance.MyStateInstance : instance.id]
}
