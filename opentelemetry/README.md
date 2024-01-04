kubectl create ns opentelemetry

kubectl apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml

helm upgrade --install opentelemetry-collector-deployment open-telemetry/opentelemetry-collector -f otel-deployment-values.yaml -n opentelemetry
helm upgrade --install opentelemetry-collector-daemon open-telemetry/opentelemetry-collector -f otel-daemon-values.yaml -n opentelemetry

