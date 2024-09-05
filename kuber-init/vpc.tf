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
