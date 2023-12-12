helm repo add nvidia https://nvidia.github.io/gpu-operator
helm repo update
kubectl create ns gpu-operator
kubectl apply -n gpu-operator -f time-slicing-config.yaml
helm upgrade gpu-operator --install -n gpu-operator nvidia/gpu-operator -f nvidia-values.yaml --version=v23.9.0
kubectl patch clusterpolicy/cluster-policy \
    -n gpu-operator --type merge \
    -p '{"spec": {"devicePlugin": {"config": {"name": "time-slicing-config", "default": "any"}}}}'