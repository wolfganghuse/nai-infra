# Cluster Install
helm upgrade --install milvus-vectordb milvus/milvus -n milvus --create-namespace -f values.yaml

# Standalone
helm upgrade --install milvus-vectordb milvus/milvus -n milvus --create-namespace -f values.yaml --set cluster.enabled=false --set etcd.replicas=1 --set pulsar.enabled=false 