provider "aws" {
  region = "us-east-1"
}

variable "instance_type" {
  description = "This is just instace type "
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "The value of ami of ubuntu"
  type        = string
  default     = "ami-084568db4383264d4"
}



# The null resouce is special resource in terraform that does not create any resource in the cloud
# the null resource is used to created provisinor 
# it is only execute once if we did not setup trigger for this 
# If to execute the provisioner again we have to use trigger
# If we trigger data is not changed then the provisioner will not execute again


resource "aws_instance" "MyNull" {
  ami = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "MyNull"
  }
}

resource "null_resource" "MyNull" {
    triggers = {
        id = timestamp()
    }
 
  provisioner "local-exec" {
    command = "echo Hello World"
  }
}