# Deployment guide — AKS MERN microservices

## Prerequisites
- Active Azure subscription and permissions to create/use AKS, ACR, public IP and Azure Disk (billable).
- Azure CLI (`az`), kubectl, bash and access to the forked Git repository.
- Existing AKS cluster and ACR, or create them using the example commands below.

## Example resource creation (charges apply)
```bash
az login
az group create -n rg-mern-aks -l centralindia
az acr create -g rg-mern-aks -n <globally-unique-acr-name> --sku Basic
az aks create -g rg-mern-aks -n aks-mern-demo --node-count 2 --node-vm-size Standard_B2s --generate-ssh-keys
```
Check VM size/quota and AKS availability in your subscription before creation.

## Deploy
Run from repository root using Bash (Linux, WSL or Azure Cloud Shell):
```bash
export AKS_RG=rg-mern-aks
export AKS_NAME=aks-mern-demo
export ACR_NAME=<your-acr-name>
read -rsp 'MongoDB password (URL-safe characters only): ' MONGO_PASSWORD; echo
export MONGO_PASSWORD
bash scripts/deploy-aks.sh
unset MONGO_PASSWORD
```
The script builds all 3 images in ACR, attaches ACR to AKS, creates a Kubernetes Secret, deploys MongoDB, both APIs, and the frontend. Passwords containing `@`, `:`, `/`, `?`, `#` or `%` must be URL-encoded for MongoDB connection strings; use an alphanumeric password for this example. For stronger security, integrate Azure Key Vault and workload identity.

## Verify
```bash
kubectl -n mern-aks get pods,deploy,svc,pvc
kubectl -n mern-aks rollout status deployment/frontend
kubectl -n mern-aks logs deploy/profile-service --tail=50
kubectl -n mern-aks get svc frontend -w
```
When `EXTERNAL-IP` is assigned, visit `http://<EXTERNAL-IP>`.
Check API routing:
```bash
curl http://<EXTERNAL-IP>/api/hello/
curl http://<EXTERNAL-IP>/api/profile/fetchUser
```
To add sample data:
```bash
curl -X POST http://<EXTERNAL-IP>/api/profile/addUser -H 'Content-Type: application/json' -d '{"name":"Demo User","age":25}'
```
Revisit the frontend to see the saved profile.

## Screenshot checklist (capture only from a real deployment)
1. Azure portal showing AKS resource and node pool.
2. ACR repository list showing three images.
3. `kubectl get pods,svc,pvc -n mern-aks` with all pods Running and PVC Bound.
4. Frontend browser page with Hello World and a saved user profile.
5. `curl` response from both APIs.
6. Optional: resource group overview, AKS workloads, application logs.
Store screenshots in `docs/screenshots/` and reference them in the report.

## Cleanup
```bash
az group delete --name rg-mern-aks --yes --no-wait
```
Only run cleanup if the resource group contains **only** assignment resources.

## Notes / limitations
- Source app was modified to replace browser `localhost` URLs with Nginx-routed relative API URLs.
- Original profile service `/health` endpoint doesn't verify DB connectivity; check API and MongoDB logs for deeper health verification.
- This repository supplies deployment files and instructions; a successful live deployment is not implied.
