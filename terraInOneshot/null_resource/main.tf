provider "aws" {
  region = "us-east-1"
}

variable "instance_type" {
  description = "Type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "The Ubuntu AMI ID to use"
  type        = string
  default     = "ami-084568db4383264d4"
}

# The aws_instance resource launches an EC2 instance using the specified AMI and instance type.
resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "ExampleInstance"
  }
}

# The null_resource does not create any cloud resources.
# It is used here only to run a local command after the EC2 instance is created.
# The 'triggers' argument causes the provisioner to run every time 'terraform apply' is executed.
resource "null_resource" "post_instance_command" {
  triggers = {
    always_run = timestamp()
  }

  # Ensure this runs after the EC2 instance creation
  depends_on = [aws_instance.example]

  # This provisioner runs a shell command locally.
  provisioner "local-exec" {
    command = "echo Hello World"
  }
}
