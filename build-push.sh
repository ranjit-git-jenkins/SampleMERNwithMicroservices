#!/usr/bin/env bash
set -euo pipefail
: "${ACR_NAME:?Set ACR_NAME}"; : "${IMAGE_TAG:=v1}"
: "${FRONTEND_CONTEXT:?Set FRONTEND_CONTEXT to actual frontend directory}"
: "${HELLO_CONTEXT:?Set HELLO_CONTEXT to actual helloService directory}"
: "${PROFILE_CONTEXT:?Set PROFILE_CONTEXT to actual profileService directory}"
REGISTRY="${ACR_NAME}.azurecr.io"
az acr login --name "$ACR_NAME"
for name in frontend hello profile; do
 case "$name" in frontend) ctx="$FRONTEND_CONTEXT"; df="docker/frontend.Dockerfile";; hello) ctx="$HELLO_CONTEXT"; df="docker/service.Dockerfile";; profile) ctx="$PROFILE_CONTEXT"; df="docker/service.Dockerfile";; esac
 docker build -f "$df" -t "$REGISTRY/mern-$name:$IMAGE_TAG" "$ctx"
 docker push "$REGISTRY/mern-$name:$IMAGE_TAG"
done
