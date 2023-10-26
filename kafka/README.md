helm repo add bitnami https://charts.bitnami.com/bitnami

helm install kafka bitnami/kafka --create-namespace -n kafka