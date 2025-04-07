module "ec2_instance" {
  source        = "./modules/ec2_instance"
  ami_id        = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  tag_name = "My_Instance"
}