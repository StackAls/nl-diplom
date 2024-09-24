#!/bin/bash

# # подготовка окружения для ansible на локальной машине
# sudo apt update && sudo apt upgrade -y
# sudo apt install software-properties-common -y
# sudo add-apt-repository ppa:deadsnakes/ppa
# sudo apt update && sudo apt install python3.12 python3.12-venv

# настройка kubespray
# git clone https://github.com/kubernetes-sigs/kubespray
cd kubespray
python3.12 -m venv .venv
.venv/bin/pip install --upgrade pip
.venv/bin/pip install -r requirements.txt
ln -sf -t playbooks ../roles

# добавляю инвентори
cp -rp inventory/sample/ inventory/cluster
cp ../inventory.ini inventory/cluster/inventory.ini

# копирую на локальную машину конфиг kubernetes
sed -i 's/# kubeconfig_localhost: false/kubeconfig_localhost: true/' inventory/cluster/group_vars/k8s_cluster/k8s-cluster.yml
sed -i 's/# supplementary_addresses_in_ssl_keys: [10.0.0.1, 10.0.0.2, 10.0.0.3]/supplementary_addresses_in_ssl_keys: [178.154.205.25]/' inventory/cluster/group_vars/k8s_cluster/k8s-cluster.yml
# ниже - для настройки ingress - в данной работе не требовалось
# sed -i 's/# helm_enabled: false/helm_enabled: true/' inventory/cluster/group_vars/k8s_cluster/addons.yml
# sed -i 's/# ingress_nginx_enabled: false/ingress_nginx_enabled: true/' inventory/cluster/group_vars/k8s_cluster/addons.yml
# sed -i 's/# ingress_nginx_host_network: false/ingress_nginx_host_network: true/' inventory/cluster/group_vars/k8s_cluster/addons.yml

# запуск плейбука
export ANSIBLE_HOST_KEY_CHECKING=False
.venv/bin/ansible-playbook -u admin --private-key ~/.ssh/nl-ya-ed25519 -i inventory/cluster/inventory.ini cluster.yml -b -v

mkdir -p ~/.kube
cp inventory/cluster/artifacts/admin.conf ~/.kube/config

# подготовка окружения для установки kube-prometheus
cd ../kube-prometheus-custom
# # установка доп ПО
# go install -a github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest
# go install github.com/brancz/gojsontoyaml@latest
# go install github.com/google/go-jsonnet/cmd/jsonnet@latest
# # Инициализация проекта
# # # Creates the initial/empty `jsonnetfile.json`
# # jb init
# # # Creates `vendor/` & `jsonnetfile.lock.json`, and fills in `jsonnetfile.json`
# # jb install github.com/prometheus-operator/kube-prometheus/jsonnet/kube-prometheus@main
# # # wget https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/example.jsonnet -O example.jsonnet
# # # nano example.jsonnet
# # # wget https://raw.githubusercontent.com/prometheus-operator/kube-prometheus/main/build.sh -O build.sh
# chmod +x build.sh
# ./build.sh

# установка Prometheus
kubectl apply --server-side -f manifests/setup
kubectl wait \
 --for condition=Established \
 --all CustomResourceDefinition \
 --namespace=monitoring
kubectl apply -f manifests/

# установка приложения
kubectl apply -f ../../../app/myapp/
