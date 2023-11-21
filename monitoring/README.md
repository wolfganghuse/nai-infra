# Monitoring with Prometheus, Thanos and Nutanix Objects

## configure objects.properties

## Update existing Prometheus

* Set labels for system namespaces

```console
kubectl label ns/kube-system monitoring=k8s
kubectl label ns/ntnx-system monitoring=k8s
```

* Patch existing Prometheus deployment to limit ServiceMonitors to `k8s` label

```console
kubectl -n ntnx-system patch --type merge prometheus/k8s -p '{"spec":{"serviceMonitorNamespaceSelector":{"matchLabels":{"monitoring": "k8s"}}}}'
```

## Deploy Thanos

```console
kubectl apply -k .
```
