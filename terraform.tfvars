subnet_web = [
    {
      cidr_range = "192.168.1.0/24"
      subnet_az = "ap-south-1a"
      is_public = true
      tags_value = {
        Name = "subnet_a"
        Tier = "Web"
      }
    },
    {
      cidr_range = "192.168.2.0/24"
      subnet_az = "ap-south-1b"
      is_public = true
      tags_value = {
        Name = "subnet_b"
        Tier = "Web"
      }
    }
    # ,{
    #   cidr_range = "192.168.3.0/24"
    #   subnet_az = "ap-south-1c"
    #   tags_value = {
    #     Name = "subnet_c"
    #     Tier = "Web"
    #   }
    # }
]

subnet_app = [
    {
      cidr_range = "192.168.4.0/24"
      subnet_az = "ap-south-1a"
      tags_value = {
        Name = "subnet_d"
        Tier = "App"
      }
    },
    {
      cidr_range = "192.168.5.0/24"
      subnet_az = "ap-south-1b"
      tags_value = {
        Name = "subnet_e"
        Tier = "App"
      }
    }
    # ,{
    #   cidr_range = "192.168.6.0/24"
    #   subnet_az = "ap-south-1c"
    #   tags_value = {
    #     Name = "subnet_f"
    #     Tier = "App"
    #   }
    # }
]

subnet_db = [
    {
      cidr_range = "192.168.7.0/24"
      subnet_az = "ap-south-1a"
      tags_value = {
        Name = "subnet_g"
        Tier = "Db"
      }
    },
    {
      cidr_range = "192.168.8.0/24"
      subnet_az = "ap-south-1b"
      tags_value = {
        Name = "subnet_h"
        Tier = "Db"
      }
    }
    # ,{
    #   cidr_range = "192.168.9.0/24"
    #   subnet_az = "ap-south-1c"
    #   tags_value = {
    #     Name = "subnet_i"
    #     Tier = "Db"
    #   }
    # }
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