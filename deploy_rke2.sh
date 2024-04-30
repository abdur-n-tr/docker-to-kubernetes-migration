#!/bin/bash

curl -sfL https://get.rke2.io |INSTALL_RKE2_TYPE=server  sh - 
systemctl enable rke2-server.service
systemctl start rke2-server.service

if [[ ":$PATH:" != *":/var/lib/rancher/rke2/bin:"* ]]; then
    echo "export PATH=$PATH:/var/lib/rancher/rke2/bin" >> "$HOME/.bashrc"
fi

if [ -z "$KUBECONFIG" ] || [ "$KUBECONFIG" != "/etc/rancher/rke2/rke2.yaml" ]; then
    export KUBECONFIG="/etc/rancher/rke2/rke2.yaml"
    echo 'export KUBECONFIG="/etc/rancher/rke2/rke2.yaml"' >> "$HOME/.bashrc"
fi

source ~/.bashrc

kubectl version
kubectl get nodes
