#!/bin/bash

# Check if one argument is provided
if [[ $# -ne 1 ]]; then
    echo "Please provide IP-Range, usage: $0 a.b.c.d-a.b.c.e"
    exit 1
fi

ADDRESS_RANGE=$1
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.10/config/manifests/metallb-native.yaml

sleep 20

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
