helm upgrade --install  kubernetes-dashboard k8s-dashboard/kubernetes-dashboard -n kubernetes-dashboard --create-namespace --version 7.0.0-alpha1 -f dashboard-values.yaml
