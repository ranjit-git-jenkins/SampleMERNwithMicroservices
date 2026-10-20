# Testing and screenshot evidence

Capture screenshots **only after running actual commands**:

1. GitHub repository file tree (code and manifests).
2. `terraform fmt -check` and `terraform validate` (local IaC validation).
3. `helm lint ./helm/mern-aks` and `helm template mern ./helm/mern-aks` (local template checks).
4. `docker images` after successful builds.
5. `az aks list -o table` (requires authenticated subscription).
6. `kubectl get nodes -o wide` and `kubectl get pods,svc,hpa -n mern` (requires real AKS deployment).
7. Application frontend and working backend API response in browser.

Do not use screenshots from other projects or portray local validation as an actual AKS deployment. Put your own images in `docs/screenshots/` and add them to the final report.
