resource "local_file" "inventory" {
  content = templatefile("${path.module}/templates/inventory.tftpl",

    {
      master = yandex_compute_instance.master
      node   = yandex_compute_instance.node
  })

  filename = "${abspath(path.module)}/ansible/inventory.ini"
}

resource "null_resource" "kubespray" {

  depends_on = [yandex_compute_instance.master, local_file.inventory]

  provisioner "local-exec" {
    command = "sleep 60"
  }

  provisioner "local-exec" {
    command = "cd ${abspath(path.module)}/ansible/;${abspath(path.module)}/ansible/kubespray.sh"
  }

  # provisioner "local-exec" {
  #   command  = "cd ${abspath(path.module)}/ansible/kubespray/;export ANSIBLE_HOST_KEY_CHECKING=False;${abspath(path.module)}/ansible/kubespray/.venv/ansible-playbook -u ubuntu --private-key=~/.ssh/nl-ya-ed25519 -i ${abspath(path.module)}/ansible/inventory.ini ${abspath(path.module)}/ansible/kubespray/cluster.yml -b -v"
  #   on_failure = continue
  #   environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  # }

  triggers = {
    # always_run = "${timestamp()}"
  }

}