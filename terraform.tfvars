subnet_main = [
    
    {
      cidr_range = "192.168.253.0/24"
      subnet_az = "ap-south-1a"
      is_public = true
      tags = {
        Name = "public_a"
      }
    },
    {
      cidr_range = "192.168.254.0/24"
      subnet_az = "ap-south-1b"
      is_public = true
      tags = {
        Name = "public_b"
      }
    },
    {
      cidr_range = "192.168.1.0/24"
      subnet_az = "ap-south-1a"
      is_public = false
      tags = {
        Name = "web_a"
      }
    },
    {
      cidr_range = "192.168.2.0/24"
      subnet_az = "ap-south-1b"
      is_public = false
      tags = {
        Name = "web_b"
      }
    },
      {
      cidr_range = "192.168.4.0/24"
      subnet_az = "ap-south-1a"
      is_public = false
      tags = {
        Name = "app_a"
      }
    },
    {
      cidr_range = "192.168.5.0/24"
      subnet_az = "ap-south-1b"
      is_public = false
      tags = {
        Name = "app_b"
      }
    },
    {
      cidr_range = "192.168.7.0/24"
      subnet_az = "ap-south-1a"
      is_public = false
      tags = {
        Name = "db_a"
      }
    },
    {
      cidr_range = "192.168.8.0/24"
      subnet_az = "ap-south-1b"
      is_public = false
      tags = {
        Name = "db_b"
      }
    },
    {
      cidr_range = "192.168.9.0/24"
      subnet_az = "ap-south-1a"
      is_public = false
      tags = {
        Name = "jenkins"
      }
    }
]

subnet_bastion = [
    {
      cidr_range = "10.0.0.0/24"
      subnet_az = "ap-south-1b"
      is_public = true
      tags = {
        Name = "bastion"
      }
    }
]

nacl_egress_rules = [
    {
      protocol = -1
      rule_no = 100
      action = "allow"
      cidr_block = "0.0.0.0/0"
      from_port = 0
      to_port = 0
    }
  ]

nacl_ingress_rules = [
  {
    protocol = -1
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }
]

web_sg_ingress_rules = [
  {
    description = "Allow HTTP"
    cidr_blocks = ["192.168.0.0/16"]
    protocol = "tcp"
    from_port = "80"
    to_port = "80"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  },
  {
    description = "Allow SHH from Bastion"
    cidr_blocks = ["10.0.0.0/24"]
    protocol = "tcp"
    from_port = "22"
    to_port = "22"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
]

web_sg_egress_rules = [
  {
    description = "Allow all Outbound"
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
    from_port = "0"
    to_port = "0"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
]

app_sg_ingress_rules = [
  {
    description = "Allow access to webapp"
    cidr_blocks = ["192.168.0.0/16"]
    protocol = "tcp"
    from_port = "8080"
    to_port = "8080"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  },
  {
    description = "Allow SHH from Bastion"
    cidr_blocks = ["10.0.0.0/24"]
    protocol = "tcp"
    from_port = "22"
    to_port = "22"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
]

app_sg_egress_rules = [
  {
    description = "Allow all Outbound"
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
    from_port = "0"
    to_port = "0"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
]

db_sg_ingress_rules = [
  {
    description = "Allow access to DB"
    cidr_blocks = ["192.168.0.0/16"]
    protocol = "tcp"
    from_port = "3000"
    to_port = "3000"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  },
  {
    description = "Allow SHH from Bastion"
    cidr_blocks = ["10.0.0.0/24"]
    protocol = "tcp"
    from_port = "22"
    to_port = "22"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
]

db_sg_egress_rules = [
  {
    description = "Allow all Outbound"
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
    from_port = "0"
    to_port = "0"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
]

alb_ingress_rules = [
  {
    description = "Allow HTTP"
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    from_port = "80"
    to_port = "80"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
]

alb_egress_rules = [
  {
    description = "Allow all Outbound"
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    from_port = "80"
    to_port = "80"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
]

bastion_sg_ingress_rules = [
  {
    description = "Allow SHH"
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    from_port = "22"
    to_port = "22"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
]

bastion_sg_egress_rules = [
  {
    description = "Allow all Outbound"
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
    from_port = "0"
    to_port = "0"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
]

jenkins_sg_ingress_rules = [
  {
    description = "Allow SHH"
    cidr_blocks = ["10.0.0.0/16"]
    protocol = "tcp"
    from_port = "22"
    to_port = "22"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
]

jenkins_sg_egress_rules = [
  {
    description = "Allow all Outbound"
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
    from_port = "0"
    to_port = "0"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
]

ec2_web = {
    image_name = ["debian-12-amd64-20240717-1811"]
    owner = ["amazon"]
    instance_size = "t2.micro"
  }

ec2_app = {
    image_name = ["debian-12-amd64-20240717-1811"]
    owner = ["amazon"]
    instance_size = "t2.micro"
  }

ec2_db = {
    image_name = ["debian-12-amd64-20240717-1811"]
    owner = ["amazon"]
    instance_size = "t2.micro"
  }

ec2_jenkins = {
    image_name = ["debian-12-amd64-20240717-1811"]
    owner = ["amazon"]
    instance_size = "t2.micro"
  }