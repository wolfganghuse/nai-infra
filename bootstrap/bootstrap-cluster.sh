#!/bin/bash
# Cluster Bootstrapping
# 0.0.1 1/9/24 Huse Initial version

### Service Account
echo "creating service account"
#. ./service-account/create-sa.sh nai-admin

### Cert-Manager
echo "deploy cert-manager"
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.yaml

### MetalLB
echo "deploy ingress via Helm"
. ./ingress/create-ingress.sh

### Ingress Helm
echo "deploy ingress via Helm"
. ./ingress/create-ingress.sh

### ArgoCD-Core
echo "deploy argocd-core"

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.9.3/manifests/core-install.yaml

