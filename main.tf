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

resource "local_sensitive_file" "bastion_private_key" {
  content = module.ssh_key_gen_a.private_key
  filename = "C:/Users/Sen/.ssh/aws_key"
}

# data "template_file" "bastion_script" {
#   template = "${file("./Key_Copy.sh.tpl")}"
#   vars = {
#     aws_private_key = "${module.ssh_key_gen_b.private_key}"
#   }
# }