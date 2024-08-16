output "servers" {
  value = [
    [for i in yandex_compute_instance.master : {
      name   = i.name
      fqdn   = i.fqdn
      ip     = i.network_interface[0].ip_address
      ip_nat = i.network_interface[0].nat_ip_address
    }],
    [for i in yandex_compute_instance.node : {
      name   = i.name
      fqdn   = i.fqdn
      ip     = i.network_interface[0].ip_address
      ip_nat = i.network_interface[0].nat_ip_address
      }
    ]
  , "kube.conf = kubespray/inventory/cluster/rtifacts/admin.conf"]
}