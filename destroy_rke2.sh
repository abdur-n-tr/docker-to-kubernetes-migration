#!/bin/bash

# Remove export PATH=/usr/local/bin if present
sed -i '/export PATH=\$PATH:\/var\/lib\/rancher\/rke2\/bin/d' "$HOME/.bashrc"

# Remove export KUBECONFIG="/etc/rancher/k3s/k3s.yaml" if present
sed -i '/export KUBECONFIG="\/etc\/rancher\/rke2\/rke2.yaml"/d' "$HOME/.bashrc"
unset KUBECONFIG

source ~/.bashrc

/usr/local/bin/rke2-uninstall.sh

