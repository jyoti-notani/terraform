terraform {
  # store remote state
  cloud {
    organization = "persy"
    workspaces {
      name = "learn-tfc-aws"
    }
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
}

provider "aws" {
  region = "us-east-2"
  alias = "east-2"
}

#  crate aws instance
resource "aws_instance" "app_server" {
  # ami           = "ami-08d70e59c07c61a3a"
  ami = "ami-05bfbece1ed5beb54"
  instance_type = "t2.micro"
  provider = aws.east-2
  tags = {
    Name = "my-first-ec2"
  }
}