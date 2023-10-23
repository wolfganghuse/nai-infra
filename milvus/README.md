## Install Milvus Operator
helm repo add milvus-operator https://zilliztech.github.io/milvus-operator/
helm repo update milvus-operator
helm -n milvus-operator upgrade --install milvus-operator milvus-operator/milvus-operator

### if Cert-Manager is already installed (as example from KServe)
helm install milvus-operator -n milvus-operator --create-namespace --set checker.disableCertManagerCheck=true

# Deploy Instance
kubectl apply -f milvus.yaml
