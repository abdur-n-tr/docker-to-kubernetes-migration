#!/bin/bash

# setup helm and helmfile
chmod u+x ./setup_helm.sh
./setup_helm.sh

# setup argocd
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# setup cert issuers
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.5/cert-manager.yaml
kubectl apply -f cert-issuers/prod_issuer.yaml

# setup pv and pvc
chmod u+x ./pvc/deploy-pvc.sh
./pvc/deploy-pvc.sh

# setup and run application in argocd
kubectl apply -f argocd-deployment.yaml

# setup ingress for services
kubectl apply -f traefik-ingress/argocd-ui-ingress.yaml
kubectl apply -f traefik-ingress/happy-compute-ingress.yaml
