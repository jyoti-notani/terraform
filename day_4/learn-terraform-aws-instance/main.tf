terraform {

  # store state in aws s3 bucket
  backend "s3" {
    bucket = "terraform-bucket-name"
    key = "myapp/terraform.tfstate"
    region = "us-west-2"
  }

  #  cloud provider
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

# aws region
provider "aws" {
  region = var.aws_region
  alias  = "west-2"
}

provider "aws" {
  region = "us-east-2"
  # alias = "east-2"
}

#  create aws instance
resource "aws_instance" "app_server" {
  ami           = var.ami
  instance_type = var.instance_type
  provider      = aws.west-2
  tags = {
    Name = "my-first-ec2"
  }
}

#  get data of s3 bucket
data "aws_s3_bucket" "selected" {
  bucket   = "terraform-bucket-name"
  provider = aws.west-2

  # filter {
  #   name   = "arn"
  #   values = ["arn:aws:s3:::terraform-bucket-name"]
  # }
}

