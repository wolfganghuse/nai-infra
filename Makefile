TARGET_NS ?= milvus
.PHONY: fix-image-pull-secrets-ns
fix-image-pull-secrets-ns: #### Add image pull secret to all available service accounts to target namespaces get around image download rate limiting issues. i.e., make fix-image-pull-secrets-ns 
	@kubectl create secret docker-registry image-pull-secret --docker-username=${DOCKER_HUB_USER} --docker-password=${DOCKER_HUB_PASS} -n ${TARGET_NS} --dry-run=client -o yaml | kubectl apply -f -
	@kubectl get serviceaccount -o name -n ${TARGET_NS} | xargs -I {} sh -c 'kubectl patch -n ${TARGET_NS} {} -p "{\"imagePullSecrets\": [{\"name\": \"image-pull-secret\"}]}"' sh







