# Cluster Install
helm upgrade --install milvus-vectordb milvus/milvus -n milvus --create-namespace -f values.yaml