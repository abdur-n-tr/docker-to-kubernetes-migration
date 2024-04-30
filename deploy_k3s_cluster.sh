#!/bin/bash

# Install k3s and configure kubeconfig
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode=644

echo $PATH

if [[ ":$PATH:" != *":/usr/local/bin:"* ]]; then
    echo "export PATH=$PATH:/usr/local/bin" >> "$HOME/.bashrc"
fi

if [ -z "$KUBECONFIG" ] || [ "$KUBECONFIG" != "/etc/rancher/k3s/k3s.yaml" ]; then
    export KUBECONFIG="/etc/rancher/k3s/k3s.yaml"
    echo 'export KUBECONFIG="/etc/rancher/k3s/k3s.yaml"' >> "$HOME/.bashrc"
fi

source ~/.bashrc

kubectl version
kubectl get nodes
