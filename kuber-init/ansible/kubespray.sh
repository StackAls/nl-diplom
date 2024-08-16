#!/bin/bash

# подготовка окружения для ansible
sudo apt update && sudo apt upgrade -y
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update && sudo apt install python3.12 python3.12-venv

# настройка kubespray
git clone https://github.com/kubernetes-sigs/kubespray
cd kubespray
python3.12 -m venv .venv
.venv/bin/pip install --upgrade pip
.venv/bin/pip install -r requirements.txt
ln -sf -t playbooks ../roles
# добавляю инвентори
cp -rp inventory/sample/ inventory/cluster
cp ../inventory.ini inventory/cluster/inventory.ini
sed -i 's/# kubeconfig_localhost: false/kubeconfig_localhost: true/' inventory/cluster/group_vars/k8s_cluster/k8s-cluster.yml
# запуск плейбука
export ANSIBLE_HOST_KEY_CHECKING=False
.venv/bin/ansible-playbook -u admin --private-key ~/.ssh/nl-ya-ed25519 -i inventory/cluster/inventory.ini cluster.yml -b -v