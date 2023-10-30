Configure base domain:

```
kubectl patch configmap config-domain -n knative-serving --patch '
data:
  kubeflow4.gptnvd.dachlab.net: ""
'
```

Configure Garbage Collection:

```
kubectl patch configmap config-gc -n knative-serving --patch '
data:
  max-non-active-revisions: "0"
  min-non-active-revisions: "0"
  retain-since-create-time: "disabled"
  retain-since-last-active-time: "disabled"
'
```
