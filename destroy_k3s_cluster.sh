#!/bin/bash

# Remove export PATH=/usr/local/bin if present
sed -i '/export PATH=\$PATH:\/usr\/local\/bin/d' "$HOME/.bashrc"

# Remove export KUBECONFIG="/etc/rancher/k3s/k3s.yaml" if present
sed -i '/export KUBECONFIG="\/etc\/rancher\/k3s\/k3s.yaml"/d' "$HOME/.bashrc"

source ~/.bashrc

/usr/local/bin/k3s-uninstall.sh
