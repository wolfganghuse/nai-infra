helm repo add bitnami https://charts.bitnami.com/bitnami

helm upgrade --install  kafka bitnami/kafka --create-namespace -n kafka -f values.yaml

