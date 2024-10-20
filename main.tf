terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.72.1"
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

resource "local_sensitive_file" "application_private_key" {
  content = module.ssh_key_gen_b.private_key
  filename = "C:/Users/Sen/.ssh/app_key"
}

resource "local_file" "ec2_ips" {
  content = "bastion public_ip: ${module.ec2_bastions.public_ip}\nalb_dns_name: {module.loadbalance_web.alb_dns_name}"
  filename = "C:/Users/Sen/Desktop/ips.txt"
}

data "template_file" "ec2_web_userdata" {
  template = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y git
              sudo git clone https://github.com/senworld/nginx-config.git /etc/nginx
              sudo apt install -y nginx -o Dpkg::Options::="--force-confold"
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo '<!doctype html>
              <html lang="en"><h1>Home page!</h1></br>
              <h3>("WebServer")</h3>
              </html>' | sudo tee /var/www/html/index.html
             EOF
}