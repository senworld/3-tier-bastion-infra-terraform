terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = vars.aws_region
  access_key = vars.aws_access_key
  secret_key = vars.aws_secret_key
}