# network ===============================
resource "yandex_vpc_network" "network" {
  name = "network"
}

resource "yandex_vpc_subnet" "public" {
  network_id     = yandex_vpc_network.network.id
  count          = length(var.vpc_zones)
  name           = "kuber-subnet-${count.index + 1}"
  zone           = var.vpc_zones[count.index]
  v4_cidr_blocks = [var.vpc_sub_public_cidr[count.index]]
}

# resource "yandex_vpc_subnet" "private" {
#   network_id     = yandex_vpc_network.network.id
#   name           = var.vpc_private
#   zone           = var.default_zone
#   v4_cidr_blocks = var.vpc_private_cidr
#   route_table_id = yandex_vpc_route_table.route_nat.id
# }

# resource "yandex_vpc_route_table" "route_nat" {
#   network_id = yandex_vpc_network.network.id

#   static_route {
#     destination_prefix = "0.0.0.0/0"
#     next_hop_address   = var.vm_nat_ip_address
#   }

# }
