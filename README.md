# MERN Application Deployment on Azure Kubernetes Service (AKS)

## Project Overview

This project demonstrates the containerization and deployment configuration of a MERN-based microservices application using Docker, Kubernetes, Helm, Terraform, and Microsoft Azure Kubernetes Service (AKS).

The project includes infrastructure-as-code, Kubernetes deployment manifests, container configurations, automation scripts, and deployment documentation.

## Technologies Used

- Microsoft Azure and Azure Kubernetes Service (AKS)
- Docker
- Kubernetes
- Helm
- Terraform
- MongoDB
- Node.js and Express.js
- React.js
- Git and GitHub
- Azure CLI

## Application Architecture

The application consists of:

1. **Frontend:** React.js web application.
2. **Hello Service:** Node.js backend microservice running on port 3001.
3. **Profile Service:** Node.js backend microservice running on port 3002.
4. **Database:** MongoDB for application data.
5. **Containerization:** Docker images for application services.
6. **Orchestration:** Kubernetes and Helm deployment configuration.
7. **Infrastructure:** Terraform configuration for Azure AKS.

## Repository Structure

```text
SampleMERNwithMicroservices/
├── backend/
├── frontend/
├── docker/
├── helm/mern-aks/
├── k8s/
├── terraform/
├── scripts/
├── docs/
├── screenshots/
└── README.md
```

## Deployment Workflow

1. Clone the GitHub repository.
2. Build Docker images for the application services.
3. Provision Azure infrastructure using Terraform.
4. Configure Azure CLI and AKS credentials.
5. Push container images to a container registry.
6. Deploy application components using Kubernetes manifests or Helm.
7. Verify Kubernetes Pods and Services.
8. Validate frontend-to-backend connectivity.
9. Perform application health checks and deployment testing.

## Example Commands

```bash
terraform init
terraform validate
terraform plan

az aks get-credentials \
  --resource-group <resource-group> \
  --name <aks-cluster-name>

kubectl get nodes
kubectl get pods -A

helm lint ./helm/mern-aks
```

Replace the placeholders with actual Azure resource names.

## Testing and Validation

The project includes deployment configurations and scripts that can be used to validate:

- Docker image builds
- Terraform configuration
- Helm chart syntax
- Kubernetes deployment readiness
- Application service connectivity
- Application functionality

## Implementation Status

Application source code and AKS deployment configuration files have been uploaded to GitHub.

Actual Azure AKS deployment, live cluster validation, and Azure Console screenshots have not yet been verified. These steps require access to an Azure subscription.

## Project Documentation

Refer to the `docs/` directory for deployment instructions and testing guidance.

## GitHub Repository

https://github.com/ranjit-git-jenkins/SampleMERNwithMicroservices

## Conclusion

This project provides a structured approach to deploying a MERN microservices application on Azure Kubernetes Service using containerization, infrastructure automation, and Kubernetes orchestration.
