# Deployment Guide (CLI-only, no Azure Portal)

1. Install Azure CLI, Terraform, kubectl, Helm, Docker.
2. Run `az login` and `az account set --subscription <subscription-id>`.
3. Copy `terraform/terraform.tfvars.example` to `terraform/terraform.tfvars` and fill in your own values. Never commit tfvars containing secrets.
4. From `terraform/`: `terraform init`, `terraform fmt`, `terraform validate`, `terraform plan`, `terraform apply`.
5. Get outputs: `terraform output`.
6. `az aks get-credentials --resource-group <rg> --name <aks>`.
7. Review the original app: ensure `npm start` exists in each backend service; check frontend build output and listening port. The provided frontend Dockerfile serves on port **80**, so adjust Helm `frontend.port` to **80** if using it unchanged.
8. Set `FRONTEND_CONTEXT`, `HELLO_CONTEXT`, `PROFILE_CONTEXT`, `ACR_NAME`, `IMAGE_TAG` and run `bash scripts/build-push.sh` from repo root.
9. `helm upgrade --install mern helm/mern-aks --namespace mern --create-namespace --set images.registry=<acr>.azurecr.io --set images.tag=v1 --set frontend.port=80`.
10. `kubectl get pods,svc,hpa -n mern`, `kubectl rollout status deployment/frontend -n mern`, and test external IP.

**Important integration work:** Check frontend API base URLs. Browser-based React apps cannot call Kubernetes-only `hello` and `profile` ClusterIP DNS names. Configure an Ingress/API reverse proxy or public API endpoint and CORS appropriately. Adjust health checks to real application routes before claiming readiness.

**Costs:** AKS worker nodes, load balancer, public IP, ACR and networking can incur charges. Destroy lab resources using `terraform destroy` when finished.
