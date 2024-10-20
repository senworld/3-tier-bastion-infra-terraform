locals {
  public_route=[
    {
      destination_cidr_block = "0.0.0.0/0"
      gateway_id = module.internet_gateway_main.id
      nat_gateway_id = null
      vpc_peering_connection_id = null
      vpc_endpoint_id = null
    },
    {
      destination_cidr_block = module.vpc_bastion.cidr_block
      gateway_id = null
      nat_gateway_id = null
      vpc_peering_connection_id = module.vpc_peer.id
      vpc_endpoint_id = null
    }
  ]
  
  private_route=[
    {
      destination_cidr_block = "0.0.0.0/0"
      gateway_id = null
      nat_gateway_id = module.nat_gateway_main.id
      vpc_peering_connection_id = null
      vpc_endpoint_id = null
    },
    {
      destination_cidr_block = module.vpc_bastion.cidr_block
      gateway_id = null
      nat_gateway_id = null
      vpc_peering_connection_id = module.vpc_peer.id
      vpc_endpoint_id = null
    }
  ]

  bastion_route=[
  {
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = module.internet_gateway_bastion.id
    nat_gateway_id = null
    vpc_peering_connection_id = null
    vpc_endpoint_id = null
  },
  {
    destination_cidr_block = module.vpc_main.cidr_block
    gateway_id = null
    nat_gateway_id = null
    vpc_peering_connection_id = module.vpc_peer.id
    vpc_endpoint_id = null
  }
]

  public_subnets=[
    module.subnet_main["public_a"].id,
    module.subnet_main["public_b"].id
  ]

  bastion_subnets=[
    module.subnet_bastion["bastion"].id
  ]

  jenkins_subnets=[
    module.subnet_main["jenkins"].id
  ]

  private_subnets=[
    module.subnet_main["web_a"].id,
    module.subnet_main["web_b"].id,
    module.subnet_main["app_a"].id,
    module.subnet_main["app_b"].id,
    module.subnet_main["db_a"].id,
    module.subnet_main["db_b"].id,
    module.subnet_main["jenkins"].id
  ]

  web_subnets=[
    module.subnet_main["web_a"].id,
    module.subnet_main["web_b"].id
  ]

  app_subnets=[
    module.subnet_main["app_a"].id,
    module.subnet_main["app_b"].id
  ]

  db_subnets=[
    module.subnet_main["db_a"].id,
    module.subnet_main["db_b"].id
  ]
}