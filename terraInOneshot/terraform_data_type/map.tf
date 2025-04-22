variable "project_env" {
  description = "This is for Projet and env"
  type = map(string)
  default = {
    Project = "project-alpha"
    environment = "dev"
  }
}

resource "aws_instance" "MyInstance_map" {
  ami = var.ami
  instance_type = var.instance_type

  tags = var.project_env

}