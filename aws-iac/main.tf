terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  required_version = ">= 1.0"

  backend "s3" {
    bucket         = "my-unique-terraform-state-bucket1"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "random_id" "suffix" {
  byte_length = 4
}

# S3 Bucket
resource "aws_s3_bucket" "example" {
  bucket = "my-iac-demo-bucket-${random_id.suffix.hex}"

  force_destroy = true

  tags = {
    Name        = "MyFirstBucket"
    Environment = "Dev"
  }
}

# Lookup default VPC
data "aws_vpc" "default" {
  default = true
}

# Lookup default Subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# EC2 Instance Module
module "ec2_instance" {
  source = "./modules/ec2_instance"

  instance_name = "demo-instance"

  ami_id        = "ami-00c8ac9147e19828e" # Amazon Linux 2023 eu-north-1
  instance_type = "t3.micro"

  subnet_id = data.aws_subnets.default.ids[0]
  vpc_id    = data.aws_vpc.default.id

  key_name = "aws-iac-key-pair"

  tags = {
    Name        = "DemoInstance"
    Environment = "Dev"
  }
}
