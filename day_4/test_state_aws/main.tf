terraform {
  backend "s3" {

    bucket = "terraform-bucket-name"

    key = "myapp/terraform.tfstate"

    region = "us-west-2"

    # shared_credentials_file = "C:\\Users\\ripusudan_v\\.aws\\credentials"

    # profile = "default"

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
  region = "us-west-2"
  alias  = "west-2"
}


#  create aws instance
resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"
  provider      = aws.west-2
  tags = {
    Name = "my-first-ec2"
  }
}



