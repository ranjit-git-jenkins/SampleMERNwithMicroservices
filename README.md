# Sample MERN with Microservices — AKS deployment assignment

Forked from [UnpredictablePrashant/SampleMERNwithMicroservices](https://github.com/UnpredictablePrashant/SampleMERNwithMicroservices).

## Components
- React frontend served by Nginx, with `/api/hello/` and `/api/profile/` proxy routes
- Node.js/Express `helloService` (3001)
- Node.js/Express `profileService` (3002)
- MongoDB StatefulSet with a persistent volume claim
- Azure Container Registry (ACR) and Azure Kubernetes Service (AKS)

## Files
- `frontend/Dockerfile`, `frontend/nginx.conf`
- `backend/helloService/Dockerfile`, `backend/profileService/Dockerfile`
- `k8s/` Kubernetes deployment, service, namespace and MongoDB manifests
- `scripts/deploy-aks.sh` image build and deployment automation
- `docs/architecture.md`, `docs/deployment-guide.md`, `docs/assignment-report.md`

## Deployment
Follow [docs/deployment-guide.md](docs/deployment-guide.md) from repository root. An Azure subscription and AKS/ACR access are required; Azure resources may incur costs.

**Verification status:** Source was reviewed and configuration prepared, but no live Azure deployment or working-app screenshots have been verified. Screenshots must be added after a real deployment.
