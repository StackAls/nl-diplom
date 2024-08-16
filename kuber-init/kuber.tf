resource "yandex_compute_instance" "master" {
  depends_on  = [yandex_compute_instance.node]
  count       = length(var.vpc_zones_master)
  platform_id = var.vm_platform_id
  name        = "master-${count.index + 1}"
  zone        = var.vpc_zones[count.index]

  resources {
    cores         = var.vm_resources["master"].cores
    memory        = var.vm_resources["master"].memory
    core_fraction = var.vm_resources["master"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_resources["master"].disk_size
    }
  }
  scheduling_policy {
    preemptible = var.vm_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public[count.index].id
    nat       = var.vm_nat_enable
  }

  metadata = var.metadata["ssh-key"]

}

resource "yandex_compute_instance" "node" {
  count       = length(var.vpc_zones)
  platform_id = var.vm_platform_id
  name        = "node-${count.index + 1}"
  zone        = var.vpc_zones[count.index]

  resources {
    cores         = var.vm_resources["node"].cores
    memory        = var.vm_resources["node"].memory
    core_fraction = var.vm_resources["node"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_resources["node"].disk_size
    }
  }
  scheduling_policy {
    preemptible = var.vm_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public[count.index].id
    nat       = var.vm_nat_enable
  }

  metadata = var.metadata["ssh-key"]

}
