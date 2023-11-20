# nai-infra

1. Deploy NKE Cluster (Production)
2. NKE Worker Pools
- Create additional worker pool for GPU and add label nodepool:gpu
- Add label to existing worker pool nodepool:worker
- Add taints to new gpu pool
3. Download kubeconfig
4. add long-term service account
