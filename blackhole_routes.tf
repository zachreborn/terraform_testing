variable "blackhole_routes" {
  type = map(object({
    destination_cidr_blocks = list(string)
    destination_subnet_names = list(string)
  }))
  default = {
    private-app = {
      destination_cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
      destination_subnet_names = []
    },
    private-persistence = {
      destination_cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
      destination_subnet_names = ["public"]
    },
    public = {
      destination_cidr_blocks = []
      destination_subnet_names = ["private-app", "transit"]
    }
  }
}

locals {
  route_table_name_to_ids = {
    # "public"              = [module.vpc.public_subnet_route_table_id]
    # "private-app"         = module.vpc.private_app_subnet_route_table_ids
    # "private-persistence" = module.vpc.private_persistence_subnet_route_table_ids
    # "transit"             = module.vpc.transit_subnet_route_table_ids

    # Replaced with hard-coded values to make testing easier
    "public"              = ["public-route-table-id1", "public-route-table-id2", "public-route-table-id3"]
    "private-app"         = ["private-app-route-table-id1", "private-app-route-table-id2", "private-app-route-table-id3"]
    "private-persistence" = ["private-persistence-route-table-id1", "private-persistence-route-table-id2", "private-persistence-route-table-id3"]
    "transit"             = ["transit-route-table-id1", "transit-route-table-id2", "transit-route-table-id3"]
  }

  subnet_name_to_cidr_blocks = {
    # "public"              = module.vpc.public_subnet_cidr_blocks
    # "private-app"         = module.vpc.private_app_subnet_cidr_blocks
    # "private-persistence" = module.vpc.private_persistence_subnet_cidr_blocks
    # "transit"             = module.vpc.transit_subnet_cidr_blocks

    # Replaced with hard-coded values to make testing easier
    "public"              = ["public-cidr-block-id1", "public-cidr-block-id2", "public-cidr-block-id3"]
    "private-app"         = ["private-app-cidr-block-id1", "private-app-cidr-block-id2", "private-app-cidr-block-id3"]
    "private-persistence" = ["private-persistence-cidr-block-id1", "private-persistence-cidr-block-id2", "private-persistence-cidr-block-id3"]
    "transit"             = ["transit-cidr-block-id1", "transit-cidr-block-id2", "transit-cidr-block-id3"]    
  }  

  # The following attempts a lookup to the local map to find the CIDR block for the given subnet name. If it fails, it
  # will use the CIDR block directly from var.blackhole_routes.

  blackhole_routes_for_cidr_blocks = flatten([
    for route_table_name, value in var.blackhole_routes : [
      for route_table_id in local.route_table_name_to_ids[route_table_name] : [
        for cidr_block in value.destination_cidr_blocks : {
          name                   = "${route_table_name}-${route_table_id}-blackhole-to-${cidr_block}"
          route_table_id         = route_table_id
          destination_cidr_block = cidr_block
        }
      ]
    ]
  ])

  blackhole_routes_for_subnet_names = flatten([
    for route_table_name, value in var.blackhole_routes : [
      for route_table_id in local.route_table_name_to_ids[route_table_name] : [
        for subnet_name in value.destination_subnet_names : [
          for cidr_block in local.subnet_name_to_cidr_blocks[subnet_name] : {
            name                   = "${route_table_name}-${route_table_id}-blackhole-to-${subnet_name}-${cidr_block}"
            route_table_id         = route_table_id
            destination_cidr_block = cidr_block
          }
        ]
      ]
    ]
  ])

  blackhole_routes = { for item in concat(local.blackhole_routes_for_cidr_blocks, local.blackhole_routes_for_subnet_names) : item.name => item }
}


output "blackhole_routes_for_cidr_blocks" {
  value = local.blackhole_routes_for_cidr_blocks
}

output "blackhole_routes_for_subnet_names" {
  value = local.blackhole_routes_for_subnet_names
}

output "blackhole_routes" {
  value = local.blackhole_routes
}
