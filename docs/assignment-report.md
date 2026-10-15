# Practice Assignment on MERN Application Using AKS

**Repository:** https://github.com/ranjit-git-jenkins/SampleMERNwithMicroservices

## Objective
Deploy a MERN microservices application on Microsoft Azure Kubernetes Service (AKS) and document deployment with real screenshots.

## Source application
Fork of https://github.com/UnpredictablePrashant/SampleMERNwithMicroservices. React frontend, Node.js Express helloService on port 3001, profileService on port 3002, MongoDB database.

## Implementation files
- Dockerfiles: `frontend/Dockerfile`, `backend/*/Dockerfile`
- Frontend Nginx API reverse proxy: `frontend/nginx.conf`
- Kubernetes manifests: `k8s/`
- Azure Container Registry build + AKS deployment: `scripts/deploy-aks.sh`
- Architecture: `docs/architecture.md`
- Execution steps: `docs/deployment-guide.md`

## Deployment evidence
**Status:** AKS execution and screenshots have not been supplied or verified. Add actual deployment screenshots under `docs/screenshots/` after running the guide. Do not claim completion without evidence.

## Conclusion
The repository contains AKS deployment automation and documentation. Full assignment completion requires running the application on AKS and adding genuine screenshots of each step.
