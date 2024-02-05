terraform {
  backend "s3" {
    bucket = "terracode"
    key    = "terraform_aws_vpc/terraform.tfstate"
    region = "us-east-1"
  }
}