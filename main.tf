terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  tags = {
    createdby   = var.createdby
    CreatedOn   = timestamp()
    project     = var.project
    Environment = terraform.workspace
  }
}

locals {
  public_key_value = file("C:/Users/Sen/.ssh/awskey.pub")
}