# Docker to Kubernetes Migration
Clone this repo: https://github.com/304442/infra.git and go into root dir `infra`

## Setup DSN record for Server Public IP
- Get the `pubilc ip` of the server

```bash
curl ifconfig.me
```

- Insert the `DSN record` of type `A` with server public IP address.  

## Setup Contabo using Terraform

Replace the contabo credentials in the `main.tf` inside `terraform` and run the following commands,

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

## Setup Kubernetes k3s Single Node Cluster

To setup k3s cluster, run the below command,
```bash
chmod u+x ./deploy_k3s_cluster.sh
./deploy_k3s_cluster.sh
```

## Deploy and Setup Full Application on k3s Cluster

To setup full application including `all services, helm, traefik ingress and argocd`, run the below command,
```bash
chmod u+x ./deploy_full_app.sh
./deploy_full_app.sh
```

## Setup Rke2 Single Node Cluster

To setup k3s cluster, run the below command,
```bash
chmod u+x ./deploy_rke2.sh
./deploy_rke2.sh

helm uninstall rke2-ingress-nginx -n kube-system
```

## Setup Helm and Helmfile

To setup helm and helmfile, run the below command,
```bash
chmod u+x ./setup_helm.sh
./setup_helm.sh
```

## Setup ArgoCD and Access UI

To setup argocd, run the below commands,
```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

We need to disable TLS in `argocd deployment` so it can work ingress as described here: https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#traefik-v22. Run the following commands to disable TLS,


```bash
kubectl edit deploy argocd-server -n argocd

```

- Edit the deployment file as per official Official Docs `The API server should be run with TLS disabled. Edit the argocd-server deployment to add the --insecure flag to the argocd-server command or set server.insecure: "true" in the argocd-cmd-params-cm`

```bash
kubectl scale deployment argocd-server --replicas=0 -n argocd
kubectl scale deployment argocd-server --replicas=1 -n argocd
```

- Argocd default username: `admin`
- To access the password, you have to get it from `argocd-initial-admin-secret` secret. To extract the secret, run the below command and copy the `password` field value,

```bash
kubectl edit secret argocd-initial-admin-secret -n argocd
```
- Now run the command to decode the password and use the decoded passoword to access argocd UI at: `https://argocd.happycloudcomputing.com/`
```bash
echo <your-password> | base64 --decode
```

## Setup Certificate Issuers

- To setup the `lets ecrypt` staging and production cert issuers, run the following commands as required,

```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.5/cert-manager.yaml
kubectl apply -f cert-issuers/staging_issuer.yaml
kubectl apply -f cert-issuers/prod_issuer.yaml
```

## Setup PV and PVC

- To setup the required pv and pvc, run the following commands as required,

```bash
./pvc/deploy-pvc.sh
```

## Deploy All Services on k3s Cluster

- Run the following command to deploy all services `without argocd`,

```bash
helmfile sync
```

- Run the following command to deploy all services `with argocd`,

```bash
kubectl apply -f argocd-deployment.yaml
```


## Deploy Traefik Ingress and Acess Services
- Run the following command to deploy all services `without argocd`,

```bash
kubectl apply -f traefik-ingress/argocd-ui-ingress.yaml
kubectl apply -f traefik-ingress/happy-compute-ingress.yaml
```

Access the services at the following URLs,

- `wireguard.happycloudcomputing.com`
- `liveide.happycloudcomputing.com`
- `prodsk.happycloudcomputing.com`
- `prodpb.happycloudcomputing.com`
- `devsk.happycloudcomputing.com`
- `devpb.happycloudcomputing.com`
- `syncthing.happycloudcomputing.com`
- `umami.happycloudcomputing.com`
- `rapidbay.happycloudcomputing.com`
- `jackett.happycloudcomputing.com`
- `qbit.happycloudcomputing.com`
- `browser.happycloudcomputing.com`
- `penpot.happycloudcomputing.com`
- `nodered.happycloudcomputing.com`
- `pinnwand.happycloudcomputing.com`
- `errorpages.happycloudcomputing.com`
- `pihole.happycloudcomputing.com`
- `vaultwarden.happycloudcomputing.com`
- `neko.happycloudcomputing.com`
- `ibga.happycloudcomputing.com`
- `glances.happycloudcomputing.com`
- `photoprism.happycloudcomputing.com`
- `activepc.happycloudcomputing.com`
- `flame.happycloudcomputing.com`
- `llama.happycloudcomputing.com`
- `gitea.happycloudcomputing.com`
- `codeserver.happycloudcomputing.com`
- `etherpad.happycloudcomputing.com`
