# terraform {
#   backend "s3" {
#     bucket         = "myterrastatecode"
#     key            = "dev/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-lock-table"
#   }
# }


provider "aws" {
  region = "us-east-1"
}