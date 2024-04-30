#!/bin/bash

kubectl apply -f pvc/dev-pb-pv.yaml 
kubectl apply -f pvc/gitea-pvc.yaml
kubectl apply -f pvc/ibga-pvc.yaml 
kubectl apply -f pvc/ide-pvc.yaml
kubectl apply -f pvc/live-ide-pvc.yaml
kubectl apply -f pvc/qbittorrent-pvc.yaml
kubectl apply -f pvc/ollama-pvc.yaml
kubectl apply -f pvc/activepieces-pvc.yaml
kubectl apply -f pvc/pihole-pvc.yaml
kubectl apply -f pvc/wireguard-pvc.yaml
kubectl apply -f pvc/jackett-pvc.yaml
