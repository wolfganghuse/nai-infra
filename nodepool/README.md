```
kubectl get nodes -l nodepool=gpu -o name | while read node; do
  kubectl taint nodes $node dedicated=gpu:NoSchedule
done
```
