# network ===============================
resource "yandex_vpc_network" "network" {
  name = "network"
}

resource "yandex_vpc_subnet" "public-a" {
  network_id     = yandex_vpc_network.network.id
  name           = var.vpc_sub_public_a
  zone           = var.default_zone
  v4_cidr_blocks = var.vpc_sub_public_a_cidr
}

resource "yandex_vpc_subnet" "public-b" {
  network_id     = yandex_vpc_network.network.id
  name           = var.vpc_sub_public_b
  zone           = var.zone_b
  v4_cidr_blocks = var.vpc_sub_public_b_cidr
}

resource "yandex_vpc_subnet" "public-d" {
  network_id     = yandex_vpc_network.network.id
  name           = var.vpc_sub_public_d
  zone           = var.zone_d
  v4_cidr_blocks = var.vpc_sub_public_d_cidr
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
