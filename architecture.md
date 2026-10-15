# AKS architecture

```mermaid
flowchart TD
  User[Browser] --> LB[Azure LoadBalancer public IP]
  LB --> FE[React static frontend / Nginx replicas]
  FE -->|/api/hello/| Hello[Hello service - ClusterIP :3001]
  FE -->|/api/profile/| Profile[Profile service - ClusterIP :3002]
  Profile --> DB[(MongoDB StatefulSet / Azure Disk PVC)]
  ACR[Azure Container Registry] -.-> FE
  ACR -.-> Hello
  ACR -.-> Profile
```

- AKS is managed Kubernetes. Frontend is the only public-facing service.
- MongoDB uses one replica with a persistent volume; this is **not** a production HA database.
- Plain HTTP is used for this classroom demo. Production requires HTTPS/TLS, ingress, backup, monitoring and stronger security controls.
