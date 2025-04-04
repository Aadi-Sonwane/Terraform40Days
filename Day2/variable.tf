variable "ami_id" {
  description = "this is the value of Ubuntu "
  type        = string
  default     = "ami-084568db4383264d4"
}



variable "instance_type" {
  description = "this is the type of instance"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "this is the subnet id"
  type        = string
  default     = "subnet-03257777b284f4c30"
}
variable "subnet_id_eu_2" {
    description = "this is the subnet id for Ohai"
    type        = string
    default     = "subnet-0989cac9a538043d6"
  }


variable "key_name" {
  description = "this is the key name"
  type        = string
  default     = "terrakey"
}