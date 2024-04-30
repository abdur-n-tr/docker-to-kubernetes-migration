#!/bin/bash

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
sudo ./get_helm.sh
rm ./get_helm.sh
helm version

wget https://github.com/roboll/helmfile/releases/download/v0.144.0/helmfile_linux_amd64
mv helmfile_linux_amd64 helmfile
chmod 777 helmfile 
sudo mv helmfile /usr/local/bin
helmfile version