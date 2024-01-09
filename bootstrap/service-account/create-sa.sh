#!/bin/bash

# Check if one argument is provided
if [[ $# -ne 1 ]]; then
    echo "Please provide service account name, usage: $0 nai-admin"
    exit 1
fi

ACCOUNT=$1

#!/bin/bash

# Check if 'admin' service account exists
if kubectl get serviceaccount $ACCOUNT > /dev/null 2>&1; then
    echo "Service account '$ACCOUNT' already exists."
else
  # Create the 'admin' service account
  echo "Creating service account '$ACCOUNT'..."
  #Create SA
  kubectl create sa $ACCOUNT

  #Create ClusterRoleBinding
  cat << EOF | kubectl create -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: $ACCOUNT-rolebinding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: $ACCOUNT
  namespace: default
EOF

  #Create Token and Cluster

  cat << EOF | kubectl create -f -
apiVersion: v1
kind: Secret
metadata:
  name: $ACCOUNT-secret
  annotations:
    kubernetes.io/service-account.name: $ACCOUNT
type: kubernetes.io/service-account-token
EOF

  TOKEN=$(kubectl get secrets $ACCOUNT-secret -o jsonpath={.data.token} | base64 --decode)
  CLUSTER=$(kubectl config view --minify -o jsonpath='{.clusters[].name}')

  #Modifing KUBECONFIG
  kubectl config set-credentials $ACCOUNT --token=$TOKEN
  kubectl config set-context $ACCOUNT-context --cluster $CLUSTER --user $ACCOUNT
  kubectl config use-context $ACCOUNT-context 
  echo "Service account 'admin' created successfully."
fi