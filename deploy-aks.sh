#!/usr/bin/env bash
set -euo pipefail
: "${ACR_NAME:?Set ACR_NAME to your existing Azure Container Registry name}"
: "${AKS_RG:?Set AKS_RG to your AKS resource group}"
: "${AKS_NAME:?Set AKS_NAME to your AKS cluster name}"
: "${MONGO_PASSWORD:?Set MONGO_PASSWORD to a strong URL-safe password}"
: "${MONGO_USER:=mernadmin}"
ACR_SERVER=$(az acr show --name "$ACR_NAME" --query loginServer -o tsv)
az aks get-credentials --resource-group "$AKS_RG" --name "$AKS_NAME" --overwrite-existing
az aks update --resource-group "$AKS_RG" --name "$AKS_NAME" --attach-acr "$ACR_NAME"
for spec in "hello:backend/helloService" "profile:backend/profileService" "frontend:frontend"; do
  name=${spec%%:*}; path=${spec#*:}
  az acr build --registry "$ACR_NAME" --image "mern-${name}:v1" "$path"
done
kubectl apply -f k8s/00-namespace.yaml
# MongoDB username/password are created in Kubernetes only, not committed to Git.
kubectl -n mern-aks create secret generic mongo-auth \
  --from-literal=username="$MONGO_USER" \
  --from-literal=password="$MONGO_PASSWORD" \
  --from-literal="mongo-url=mongodb://${MONGO_USER}:${MONGO_PASSWORD}@mongodb:27017/mernapp?authSource=admin" \
  --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f k8s/10-mongodb.yaml
kubectl -n mern-aks rollout status statefulset/mongodb --timeout=300s
sed -e "s|IMAGE_HELLO|${ACR_SERVER}/mern-hello:v1|g" \
    -e "s|IMAGE_PROFILE|${ACR_SERVER}/mern-profile:v1|g" \
    k8s/20-backends.yaml | kubectl apply -f -
sed "s|IMAGE_FRONTEND|${ACR_SERVER}/mern-frontend:v1|g" k8s/30-frontend.yaml | kubectl apply -f -
kubectl -n mern-aks rollout status deployment/hello-service --timeout=300s
kubectl -n mern-aks rollout status deployment/profile-service --timeout=300s
kubectl -n mern-aks rollout status deployment/frontend --timeout=300s
kubectl -n mern-aks get pods,svc,pvc
