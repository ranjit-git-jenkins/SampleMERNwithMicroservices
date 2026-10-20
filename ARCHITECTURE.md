# Target Architecture

GitHub source -> Docker build -> Azure Container Registry -> AKS cluster

AKS: Azure LoadBalancer -> frontend React/Nginx -> API endpoints (must be exposed through a reverse proxy/Ingress) -> helloService and profileService -> MongoDB.

Terraform provisions resource group, VNet/subnet, ACR, AKS and ACR pull role assignment. Helm deploys workloads and CPU HPAs. Example MongoDB is ephemeral and unauthenticated, so it is **not production-ready**.
