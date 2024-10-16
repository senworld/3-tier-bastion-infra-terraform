variable "aws_region" {
 type = string
 default = "ap-south-1"
}

variable "project" {
  type = string
  default = "Java-3-Tier-Deployment"
}

variable "createdby" {
  type = string
  default = "sen"
}

variable "subnet_main" {
  type = any
}

variable "subnet_bastion" {
  type = any
}

variable "root_tags" {
  default = {
    Name = "Root"
  }
}

variable "bastion_tags" {
  default = {
    Name = "Bastion"
  }
}

variable "web_tags" {
  default = {
    Name = "Webtier"
  }
}

variable "app_tags" {
  default = {
    Name = "Apptier"
  }
}

variable "db_tags" {
  default = {
    Name = "Dbtier"
  }
}

variable "is_public" {
  type = bool
  default = false
}

variable "nacl_egress_rules" {
  type = any
}

variable "nacl_ingress_rules" {
  type = any
}

variable "web_sg_ingress_rules" {
 type = any 
 default = null
}

variable "web_sg_egress_rules" {
 type = any 
 default = null
}

# variable "app_sg_rules" {
#   type = any
# }

# variable "db_sg_rules" {
#   type = any
# }

variable "alb_ingress_rules" {
 type = any 
 default = null
}

variable "alb_egress_rules" {
 type = any 
 default = null
}

variable "bastion_sg_ingress_rules" {
 type = any 
 default = null
}

variable "bastion_sg_egress_rules" {
 type = any 
 default = null
}

variable "ec2_web" {
  type = any
}

# variable "ec2_app" {
#   type = any
# }

# variable "ec2_db" {
#   type = any
# }