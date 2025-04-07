# creating provider for aws provider 
provider "aws" {
  region = "us-east-1"
}

# creating ec2 instance 

resource "aws_instance" "MyDemoInstance" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"
}

# creating a s3 bucket in same region 

resource "aws_s3_bucket" "state_holder" {
  bucket = "terra-state-demo-aadi"
}

# creating a dynamodb table to hold locking of state 
resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform_lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

}