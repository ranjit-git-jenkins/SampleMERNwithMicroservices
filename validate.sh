#!/usr/bin/env bash
set -euo pipefail
helm lint ./helm/mern-aks
helm template mern ./helm/mern-aks > /tmp/mern-aks-rendered.yaml
if command -v kubectl >/dev/null; then kubectl apply --dry-run=client -f /tmp/mern-aks-rendered.yaml >/dev/null; fi
echo "Template validation complete; this does not prove AKS deployment."
