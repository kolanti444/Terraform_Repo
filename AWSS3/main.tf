provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

terraform {
  backend "s3" {
    bucket = "my-tf-test-bucket-21-02-2023"
    key    = "app/pre-prod/state.tf"
    region = "us-east-1"
  }
}