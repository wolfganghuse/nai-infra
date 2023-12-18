# nai-infra

1. Deploy NKE Cluster (Production)
K8s version: 1.25.6-1 (NKE 2.9, OS Version 1.6)
Resources:  3 cpu nodes with 12 vCPUs, 16G memory and 120 GB storage
2. NKE Worker Pools
- Create additional worker pool for GPU and add label nodepool:gpu
Resources:  At least 1 gpu node with 12 vCPUs, 40G memory and 120 GB storage
- Add label to existing worker pool nodepool:worker
- Add taints to new gpu pool
3. Download kubeconfig
4. add long-term service account
5. Install GPU-Operator

