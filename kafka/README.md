helm repo add bitnami https://charts.bitnami.com/bitnami

helm upgrade --install  kafka bitnami/kafka --create-namespace -n kafka -f values.yaml --version=26.8.0


Change number of Partitions to allow scaling knative

kafka-topics.sh --bootstrap-server localhost:9092 --alter --topic OSSEvents --partitions 4