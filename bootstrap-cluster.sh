#!/bin/bash

# Check if one argument is provided
if [[ $# -ne 1 ]]; then
    echo "Please provide IP-Range, usage: $0 a.b.c.d-a.b.c.e"
    exit 1
fi
ADDRESS_RANGE=$1


# Cluster Bootstrapping
# 0.0.1 1/9/24 Huse Initial version

### Service Account
echo "creating service account"
. ./bootstrap/service-account/create-sa.sh nai-admin

### MetalLB

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.10/config/manifests/metallb-native.yaml

kubectl wait --for condition=established crd addresspools.metallb.io
kubectl wait --for condition=established webhook ipaddresspoolvalidationwebhook.metallb.io

cat << EOF | kubectl create -f -
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: cheap
  namespace: metallb-system
spec:
  addresses:
  - $ADDRESS_RANGE
EOF

cat << EOF | kubectl create -f -
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: empty
  namespace: metallb-system
EOF

### Handover to ArgoCD-Core
echo "deploy argocd-core"

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.9.3/manifests/core-install.yaml
kubectl wait --for condition=established crd applicationsets.argoproj.io

echo "start cluster bootstrapping"
kustomize build clusters/base/argocd | kubectl apply -f -

echo "everything´s finished. To log into ArgoCD to check apps, run:"
echo "kubectl config set-context --current --namespace=argocd"
echo "argocd login --core"

