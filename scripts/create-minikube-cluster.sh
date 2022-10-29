#!/bin/bash

# https://docs.px.dev/installing-pixie/setting-up-k8s/minikube-setup/

# shellcheck disable=SC1090
source ~/apps/bin/sc_proxy
minikube start --driver=hyperkit --cni=flannel \
  --cpus=4 --memory=8000 --disk-size=50000mb \
  --docker-env HTTP_PROXY=http://$HTTP_PROXY \
  --docker-env HTTPS_PROXY=https://$HTTPS_PROXY \
  --docker-env NO_PROXY=$NO_PROXY
#😄  Darwin 12.5.1 上的 minikube v1.26.1
#    ▪ MINIKUBE_ACTIVE_DOCKERD=minikube
#✨  根据用户配置使用 hyperkit 驱动程序
#👍  Starting control plane node minikube in cluster minikube
#🔥  Creating hyperkit VM (CPUs=4, Memory=8000MB, Disk=50000MB) ...
#🌐  找到的网络选项：
#    ▪ HTTP_PROXY=http://192.168.1.227:1087
#    ▪ HTTPS_PROXY=http://192.168.1.227:1087
#    ▪ NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24,192.168.64.0/24
#🐳  正在 Docker 20.10.17 中准备 Kubernetes v1.24.3…
#    ▪ env HTTP_PROXY=http://http://192.168.1.227:1087
#    ▪ env HTTPS_PROXY=https://http://192.168.1.227:1087
#    ▪ env NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24,192.168.64.0/24
#    ▪ env HTTP_PROXY=http://192.168.1.227:1087
#    ▪ env HTTPS_PROXY=http://192.168.1.227:1087
#    ▪ Generating certificates and keys ...
#    ▪ Booting up control plane ...
#    ▪ Configuring RBAC rules ...
#🔗  Configuring Flannel (Container Networking Interface) ...
#🔎  Verifying Kubernetes components...
#    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
#🌟  Enabled addons: storage-provisioner, default-storageclass
#🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default

kubectl create ns plc-dev
kubectl create ns plc-dev-monitoring