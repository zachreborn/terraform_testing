variable "blackhole_routes" {
  type = map(object({
    destination_cidr_blocks = list(string)
  }))
  default = {
    private-app = {
      destination_cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
    },
    private-persistence = {
      destination_cidr_blocks = ["100.66.0.0/16", "10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
    },
    public = {
      destination_cidr_blocks = ["100.64.0.0/16", "10.0.0.0/22"]
    }
  }
}

locals {
  blackhole_routes = {
    for item in flatten([
    for route_table, value in var.blackhole_routes : [
      for cidr_block in value.destination_cidr_blocks : {
        route_table = route_table
        cidr_block  = cidr_block
      }
    ]
  ]) : "${item.route_table}_${item.cidr_block}" => item
  }
}