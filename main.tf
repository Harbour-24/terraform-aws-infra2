terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41.0"
    }
  }
  cloud {
    organization = "aws-infra2026"

    workspaces {
      name = "aws-infra"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"
}

resource "aws_instance" "test_server" {
  ami           = "ami-0eba6c58b7918d3a1"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id

  tags = {
    Name      = "TestInstance",
    ManagedBy = "HCP Terraform"
  }
}
