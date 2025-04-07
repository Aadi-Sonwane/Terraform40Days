
terraform {
  backend "s3" {
    bucket = "terra-state-demo-aadi"
    region = "us-east-1"
    key = "state/terraform.tfstate"
    dynamodb_table = "terraform_lock"
  }
}