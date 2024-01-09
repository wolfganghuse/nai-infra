# nai-infra

## Versions used in this deployment
metallb 0.13.10
nginx-ingress 1.9.4
cert manager 1.13.2
Open Telemetry 0.91.0
ArgoCD 2.9.3

## Bootstrap Cluster
kustomize build clusters/base/argocd | kubectl apply -f -
### Log into ArgoCD-core
kubectl config set-context --current --namespace=argocd
argocd login --core

## Management Cluster
1. Deploy NKE Cluster (Production)
K8s version: 1.25.6-1 (NKE 2.9, OS Version 1.6)
Resources:  3 cpu nodes with 12 vCPUs, 16G memory and 120 GB storage
2. Download kubeconfig
3. add long-term service account nai-admin
4. Install MetalLB
5. Install NGINX Ingress
6. Install Cert Manager and configure for your DNS provider
7. 

## Workload Cluster
1. Deploy NKE Cluster (Production)
K8s version: 1.25.6-1 (NKE 2.9, OS Version 1.6)
Resources:  3 cpu nodes with 12 vCPUs, 16G memory and 120 GB storage
2. NKE Worker Pools
- Create additional worker pool for GPU and add label nodepool:gpu
Resources:  At least 1 gpu node with 12 vCPUs, 40G memory and 120 GB storage
- Add label to existing worker pool nodepool:worker
- Add taints to new gpu pool
3. Download kubeconfig
4. add long-term service account
5. Install GPU-Operator

