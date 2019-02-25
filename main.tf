provider "aws" {
  region = "us-west-1"
}

data "aws_s3_bucket" "wojtak" {
  bucket = "wojtak"
}
