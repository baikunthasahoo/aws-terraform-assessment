
terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket         = "sahoo-terraform-state-unique-2026"
    key            = "ec2-assessment/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    use_lockfile   = true
    encrypt        = true
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "account-a"
}
